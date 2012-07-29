class Parser
  AT = /(?:@urbandictionary )?/i
  WTF = /(?:(?:what|whut|wut)(?: the fuck| the hell| the shit)?|wtf)/i
  WORD = /['"]?([\w\s]+)['"]?/
  
  REGEXPS = [
    /\A#{AT}#{WTF} is(?: a| an)? #{WORD}(?: anyway)?\??\Z/i,
    /\A#{AT}#{WTF} does #{WORD}(?: even| really)? mean\??\Z/i,
    /^[@#]urbandictionary #{WORD}$/i,
    /^#{WORD} [@#]urbandictionary$/i
  ]

  def self.parse(string)
    REGEXPS.find { |regexp| string =~ regexp }
    if (match = $1)
      match.strip!
      match.sub!(/ anyway$/, '')
      match unless match =~ /^(it|it all|it even|that|this|that even|that really|air|today|going on|up|happening|good)$/i
    end
  end
end