require File.dirname(__FILE__) + '/ud'
require File.dirname(__FILE__) + '/parser'
require File.dirname(__FILE__) + '/formatter'

class Responder
  def self.respond(status)
    parsed = Parser.parse(status.text)

    if parsed
      puts "MATCH #{status.text.inspect}"
      puts "PARSED #{parsed.inspect}"

      result = UD.define(parsed)
      if result["result_type"] == "exact" && !result["list"].empty?
        response = Formatter.format(status.from_user, result["list"].first)
        Twitter.update(response, in_reply_to_status_id: status.id) if ENV["UPDATE_TWITTER"]
        puts "UPDATE #{response.inspect} (in_reply_to #{status.id.inspect})"
      end
    end
  end
end