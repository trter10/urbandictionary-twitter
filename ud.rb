require 'httparty'

class UD
  include HTTParty
  
  base_uri "http://api.urbandictionary.com/v0/"
  default_params api_key: "5c1a3b3898abb75acc92b14be9e48c2d"
  
  def self.define(term)
    get "/define", query: {term: term}
  end
end