class Parser
  def self.parse(string)
    out = string[/what does "?(\w+)"? mean\?/, 1]
    return nil if %w[it that].include? out
    out
  end
end