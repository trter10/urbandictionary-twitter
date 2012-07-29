class Parser
  REGEXPS = [
    # /^[^"]*what(?: the fuck| the hell)? does "?([\w\s]+)"? (mean|actually mean)/i,
    # /^[^"]*what(?: the fuck| the hell)? is an? "?([\s\w]+)"?\?/i,
    # /^define "?([\w\s]+)"?\.?$/i,
    # /@urbandictionary (.+)/i
    /^what is ([\w\s]+)\?$/,
    /^what does ([\w\s]+) mean\?$/
  ]

  def self.parse(string)
    REGEXPS.find { |regexp| string =~ regexp }
    match = $1
    return nil if match =~ /^(it|it all)$/
    match
  end
end