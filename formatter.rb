class Formatter
  LENGTH = 140
  
  def self.format(input)
    head = "#{input["word"]}: "
    tail = "... #{input["permalink"]}"
    body = input["definition"].gsub(/[\r\n]+/, ' ')[0..LENGTH-1-head.length-tail.length]
    
    head + body + tail
  end
end