class Formatter
  LENGTH = 140
  
  def self.format(username, input)
    head = "@#{username}: #{input["word"]}: "
    tail = " #{input["permalink"]}"
    body = input["definition"].gsub(/[\r\n]+/, ' ').gsub(/[\[\]]/, '').gsub(/\s{2,}/, ' ')

    body = "#{body[0..LENGTH - head.length - tail.length - 1 - 3]}..." if (head.length + body.length + tail.length) > LENGTH
    
    head + body + tail
  end
end
