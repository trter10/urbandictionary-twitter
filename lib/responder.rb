require File.dirname(__FILE__) + '/ud'
require File.dirname(__FILE__) + '/parser'
require File.dirname(__FILE__) + '/formatter'

class Responder
  def self.respond(status)
    puts "STATUS #{status.text.inspect}" if ENV["VERBOSE"]

    parsed = Parser.parse(status.text)

    if parsed
      puts "PARSED #{parsed.inspect}" if ENV["VERBOSE"]

      result = UD.define(parsed)

      if result["result_type"] == "exact" && !result["list"].empty?
        response = Formatter.format(status.from_user, result["list"].first)

        if ENV["UPDATE_TWITTER"]
          Twitter.update(response, in_reply_to_status_id: status.id)
        end

        puts "UPDATE #{response.inspect} (in_reply_to #{status.id.inspect})" if ENV["VERBOSE"]
        $graphite.send 'twitter.update'
      end
    end
  end
end