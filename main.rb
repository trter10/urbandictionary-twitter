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
    
    puts e.rate_limit.inspect if e.respond_to?(:rate_limit)
  end
end