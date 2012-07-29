class Parser
  REGEXPS = [
    # /^[^"]*what(?: the fuck| the hell)? does "?([\w\s]+)"? (mean|actually mean)/i,
    # /^[^"]*what(?: the fuck| the hell)? is an? "?([\s\w]+)"?\?/i,
    # /^define "?([\w\s]+)"?\.?$/i,
    # /@urbandictionary (.+)/i
    /^(?:@urbandictionary )?what(?: the fuck| the hell| the shit)? is ['"]?([\w\s]+)['"]?(?: anyway)?\?$/i,
    /^(?:@urbandictionary )?what(?: the fuck| the hell| the shit)? does ['"]?([\w\s]+)['"]?(?: even| really)? mean\?$/i,
  ]

  def self.parse(string)
    REGEXPS.find { |regexp| string =~ regexp }
    if (match = $1)
      match.sub!(/ anyway$/, '')
      match unless match =~ /^(it|it all|it even)$/i
    end
  end
end