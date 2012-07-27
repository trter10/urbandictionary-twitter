require 'tweetstream'
require './parser'

TweetStream.configure do |config|
  config.consumer_key = ENV["CONSUMER_KEY"]
  config.consumer_secret = ENV["CONSUMER_SECRET"]
  config.oauth_token = ENV["OAUTH_TOKEN"]
  config.oauth_token_secret = ENV["OAUTH_TOKEN_SECRET"]
end

TweetStream::Client.new.track("what does * mean") do |status|
  puts status.text
  puts status.screen_name
  puts Parser.parse(status.text)
end