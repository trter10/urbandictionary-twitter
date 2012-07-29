class Parser
  REGEXPS = [
    # /^[^"]*what(?: the fuck| the hell)? does "?([\w\s]+)"? (mean|actually mean)/i,
    # /^[^"]*what(?: the fuck| the hell)? is an? "?([\s\w]+)"?\?/i,
    # /^define "?([\w\s]+)"?\.?$/i,
    # /@urbandictionary (.+)/i
    /^what(?: the fuck| the hell| the shit)? is ['"]?([\w\s]+)['"]?(?: anyway)?\?$/i,
    /^what(?: the fuck| the hell| the shit)? does ['"]?([\w\s]+)['"]?(?: even| really)? mean\?$/i,
  ]

  def self.parse(string)
    REGEXPS.find { |regexp| string =~ regexp }
    match = $1
    match.sub!(/ anyway$/, '')
    return nil if match =~ /^(it|it all|it even)$/
    match
  end
end