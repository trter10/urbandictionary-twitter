Bundler.require
require File.dirname(__FILE__) + '/lib/config'
require File.dirname(__FILE__) + '/lib/responder'

$statsd = Statsd.new(ENV['STATSD_HOST'])

client = TweetStream::Client.new

%w/error inited limit unauthorized anything reconnect no_data_received enhance_your_calm/.each do |event|
  client.send("on_#{event}") do
    puts "TWEETSTREAM #{event}"
    $statsd.increment "twitter.#{event}"
  end
end

keywords = File.readlines("./keywords.txt").map(&:strip)

client.track(*keywords) do |status|
  $statsd.increment 'twitter.track'

  begin
    Responder.respond(status)
  rescue Exception => e
    $statsd.increment 'twitter.error'

    puts e.inspect
    puts e.backtrace
    Airbrake.notify e
  end
end
