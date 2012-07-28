class Parser
  REGEXPS = [
    /^[^"]*what(?: the fuck| the hell)? does "?([\w\s]+)"? (mean|actually mean)/i,
    /^[^"]*what(?: the fuck| the hell)? is an? "?([\s\w]+)"?\?/i,
    /^define "?([\w\s]+)"?\.?$/i,
    /@urbandictionary (.+)/i
  ]

  def self.parse(string)
    return nil if string =~ /^@/ && string !~ /^@urbandictionary/
    REGEXPS.find { |regexp| string =~ regexp }
    match = $1
    return nil if match =~ /^it|that|this|that even|she|he$/i
    match
  end
end