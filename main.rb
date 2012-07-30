Bundler.require
require './parser'
require './ud'
require './formatter'
require './config'
require './responder'

client = TweetStream::Client.new
client.on_error { puts "TWEETSTREAM error" }
client.on_inited { puts "TWEETSTREAM inited" }
client.on_limit { puts "TWEETSTREAM limit" }
client.on_unauthorized { puts "TWEETSTREAM unauthorized" }
client.on_anything { puts "TWEETSTREAM anything" }
client.on_reconnect { puts "TWEETSTREAM reconnect" }
client.on_no_data_received { puts "TWEETSTREAM no_data_received" }
client.on_enhance_your_calm { puts "TWEETSTREAM enhance_your_calm" }

keywords = File.readlines("./keywords.txt").map(&:strip)

client.track(*keywords) do |status|
  Responder.respond(status)
end