describe "Keywords" do
  it do
    keywords = File.readlines(File.dirname(__FILE__) + "/../keywords.txt").map(&:strip)
    parser_should_match = File.readlines(File.dirname(__FILE__) + "/parser_should_match.txt").map(&:strip)
    
    parser_should_match.each do |string|
      if keywords.find { |keyword| string.downcase.include? keyword.downcase }.nil?
        fail "#{string.inspect} should match at least one keyword"
      end
    end
  end
end