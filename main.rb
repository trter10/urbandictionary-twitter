Bundler.require
require './parser'
require './ud'

TweetStream.configure do |config|
  config.consumer_key = ENV["CONSUMER_KEY"]
  config.consumer_secret = ENV["CONSUMER_SECRET"]
  config.oauth_token = ENV["ACCESS_TOKEN"]
  config.oauth_token_secret = ENV["ACCESS_TOKEN_SECRET"]
end

client = TweetStream::Client.new
client.on_error { puts "error" }
client.on_inited { puts "inited" }
client.on_limit { puts "limit" }
client.on_unauthorized { puts "unauthorized" }
client.on_anything { puts "anything" }
client.on_reconnect { puts "reconnect" }
client.on_no_data_received { puts "no_data_received" }
client.on_enhance_your_calm { puts "enhance_your_calm" }

client.track("what does", "what the fuck", "what the hell") do |status|
  puts status.text
  
  begin  
    parsed = Parser.parse(status.text)
    if parsed
      ap status
      ap parsed
    
      result = UD.define(parsed)
      if result["result_type"] == "exact" && !result["list"].empty?
        ap result["list"].first
      end
    end
  rescue Exception => e
    puts e.inspect
    puts e.backtrace
  end
end