Bundler.require
require File.dirname(__FILE__) + '/lib/config'
require File.dirname(__FILE__) + '/lib/responder'

client = TweetStream::Client.new

%w/error inited limit unauthorized anything reconnect no_data_received enhance_your_calm/.each do |event|
  client.send("on_#{event}") { puts "TWEETSTREAM #{event}" }
end

keywords = File.readlines("./keywords.txt").map(&:strip)

client.track(*keywords) do |status|
  begin
    Responder.respond(status)
  rescue Exception => e
    if e.is_a?(Twitter::Error)
      puts "TWITTER_ERROR", {
        http_headers: e.http_headers,
        ratelimit_reset: e.ratelimit_reset,
        ratelimit_limit: e.ratelimit_limit,
        ratelimit_remaining: e.ratelimit_remaining,
        retry_after: e.retry_after
      }
    end
    
    puts e.inspect
    puts e.backtrace
    Airbrake.notify e
  end
end