describe "Keywords" do
  it do
    keywords = File.readlines("./keywords.txt").map(&:strip)
    parser_should_match = File.readlines("./parser_should_match.txt").map(&:strip)
    
    parser_should_match.each do |string|
      raise "#{string.inspect} included no keywords" unless keywords.find { |keyword| string.downcase.include? keyword.downcase }
    end
  end
end