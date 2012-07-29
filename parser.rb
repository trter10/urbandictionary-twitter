class Parser
  REGEXPS = [
    /^(?:@urbandictionary )?(?:what|whut|wut)(?: the fuck| the hell| the shit)? is(?: a| an)? ['"]?([\w\s]+)['"]?(?: anyway)?\?$/i,
    /^(?:@urbandictionary )?(?:what|whut|wut)(?: the fuck| the hell| the shit)? does ['"]?([\w\s]+)['"]?(?: even| really)? mean\?$/i,
    /@urbandictionary ['"]?([\w\s]+)['"]?/i
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