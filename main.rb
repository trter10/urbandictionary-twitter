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
    puts e.inspect
    puts e.backtrace
    Airbrake.notify e

    if e.is_a?(Twitter::Error)
      puts "TWITTER_ERROR #{e.http_headers.inspect}"
      puts "TWITTER_ERROR #{e.ratelimit_reset.inspect}"
      puts "TWITTER_ERROR #{e.ratelimit_limit.inspect}"
      puts "TWITTER_ERROR #{e.ratelimit_remaining.inspect}"
      puts "TWITTER_ERROR #{e.retry_after.inspect}"
    end
  end
end