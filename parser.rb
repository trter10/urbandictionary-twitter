class Parser
  WTF = /(?:what|whut|wut)(?: the fuck| the hell| the shit)?/i
  WORD = /['"]?([\w\s]+)['"]?/
  AT = /(?:@urbandictionary )?/i
  
  REGEXPS = [
    /^#{AT}#{WTF} is(?: a| an)? #{WORD}(?: anyway)?\??$/i,
    /^#{AT}#{WTF} does #{WORD}(?: even| really)? mean\??$/i,
    /^@urbandictionary ['"]?([\w\s]+)['"]?$/i
  ]

  def self.parse(string)
    REGEXPS.find { |regexp| string =~ regexp }
    if (match = $1)
      match.strip!
      match.sub!(/ anyway$/, '')
      match unless match =~ /^(it|it all|it even|that|that even|that really)$/i
    end
  end
end