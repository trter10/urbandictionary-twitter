describe "Keywords" do
  it do
    keywords = File.readlines("./keywords.txt").map(&:strip)
    parser_should_match = File.readlines("./parser_should_match.txt").map(&:strip)
    
    parser_should_match.each do |string|
      if keywords.find { |keyword| string.downcase.include? keyword.downcase }.nil?
        fail "#{string.inspect} should match at least one keyword"
      end
    end
  end
end