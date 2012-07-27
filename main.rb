Bundler.require
require './parser'
require './ud'

TweetStream.configure do |config|
  config.consumer_key = ENV["CONSUMER_KEY"]
  config.consumer_secret = ENV["CONSUMER_SECRET"]
  config.oauth_token = ENV["OAUTH_TOKEN"]
  config.oauth_token_secret = ENV["OAUTH_TOKEN_SECRET"]
end

client = TweetStream::Client.new
client.on_error { puts "error" }

client.track("what does", "what the fuck", "what the hell") do |status|
  puts status.text
  
  parsed = Parser.parse(status.text)
  if parsed
    ap status
    ap parsed
    
    result = UD.define(parsed)
    if result["result_type"] == "exact" && !result["list"].empty?
      ap result["list"].first
    end
  end
end