class Parser
  def self.parse(string)
    out = string[/what(?: the fuck| the hell)? does "?([\w\s]+)"? (mean|actually mean)/i, 1]
    out ||= string[/what(?: the fuck| the hell)? is an? "?([\s\w]+)"?\?/i, 1]
    return nil if %w[it that].include? out
    out
  end
end