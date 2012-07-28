Bundler.require
require './parser'
require './ud'
require './formatter'

raise "Missing env var" if %w[CONSUMER_KEY CONSUMER_SECRET ACCESS_TOKEN ACCESS_TOKEN_SECRET].find { |key| ENV[key].nil? }

[TweetStream, Twitter].each { |klass| klass.configure do |config|
  config.consumer_key = ENV["CONSUMER_KEY"]
  config.consumer_secret = ENV["CONSUMER_SECRET"]
  config.oauth_token = ENV["ACCESS_TOKEN"]
  config.oauth_token_secret = ENV["ACCESS_TOKEN_SECRET"]
end}

client = TweetStream::Client.new
client.on_error { puts "TWEETSTREAM error" }
client.on_inited { puts "TWEETSTREAM inited" }
client.on_limit { puts "TWEETSTREAM limit" }
client.on_unauthorized { puts "TWEETSTREAM unauthorized" }
client.on_anything { puts "TWEETSTREAM anything" }
client.on_reconnect { puts "TWEETSTREAM reconnect" }
client.on_no_data_received { puts "TWEETSTREAM no_data_received" }
client.on_enhance_your_calm { puts "TWEETSTREAM enhance_your_calm" }

client.track("what does", "what the", "what is") do |status|
  puts "STATUS #{status.text.inspect}"
  
  begin
    parsed = Parser.parse(status.text)
    
    if parsed
      puts "PARSED #{parsed.inspect}"

      result = UD.define(parsed)
      if result["result_type"] == "exact" && !result["list"].empty?
        response = Formatter.format(status.from_user, result["list"].first)
        Twitter.update(response, in_reply_to_status_id: status.id) if ENV["UPDATE_TWITTER"]
        puts "RESPONSE #{response.inspect}"
      end
    end
  rescue Exception => e
    puts e.inspect
    puts e.backtrace
  end
end