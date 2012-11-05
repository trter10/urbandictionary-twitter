Bundler.require
require File.dirname(__FILE__) + '/lib/config'
require File.dirname(__FILE__) + '/lib/responder'

$graphite = HostedGraphite.new

client = TweetStream::Client.new

%w/error inited limit unauthorized anything reconnect no_data_received enhance_your_calm/.each do |event|
  client.send("on_#{event}") do
    puts "TWEETSTREAM #{event}"
    $graphite.send "twitter.#{event}"
  end
end

keywords = File.readlines("./keywords.txt").map(&:strip)

client.track(*keywords) do |status|
  $graphite.send 'twitter.track'

  begin
    Responder.respond(status)
  rescue Exception => e
    $graphite.send 'twitter.error'

    puts e.inspect
    puts e.backtrace
    Honeybadger.notify e
  end
end
