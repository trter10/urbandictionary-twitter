class Parser
  WTF = /(?:(?:what|whut|wut)(?: the fuck| the hell| the shit)?|wtf)/i
  QUOTED_WORD = /['"]?([\w\s]+)['"]?/
  
  REGEXPS = [
    /\A(?:@urbandictionary )#{WTF} is(?: a| an)? #{QUOTED_WORD}(?: anyway)?\??\Z/i,
    /\A(?:what|whut|wut)(?: the fuck| the hell| the shit) is(?: a| an)? #{QUOTED_WORD}\??\Z/i,
    /\A(?:what is|what's) the definition of #{QUOTED_WORD}\??\Z/i,
    /\A(?:@urbandictionary )?#{WTF} does #{QUOTED_WORD}(?: even| really)? mean\??\Z/i,
    /\A[@#]urbandictionary define #{QUOTED_WORD}\Z/i,
    /\A[@#]urbandictionary #{QUOTED_WORD}\Z/i,
    /\A#{QUOTED_WORD} [@#]urbandictionary\Z/i,
    /\Adefine #{QUOTED_WORD}\Z/i
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