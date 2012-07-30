require './parser'

describe Parser do
  # Twitter.status(229631506031718400).text
  
  def self.describe_lines(string, expected)
    method = string.respond_to?(:each_line) ? :each_line : :each
    string.send(method) do |line|
      line.strip!
      it line.inspect do
        Parser.parse(line).should == expected
      end
    end
  end

  describe "should match" do
    describe_lines File.readlines(File.dirname(__FILE__) + "/parser_should_match.txt").map(&:strip), "hand job"
  end

  describe "shouldn't match" do
    describe_lines [
      "@animullcrackers \nWhat is this",
      "@animullcrackers \nWhat does this mean"
    ], nil
    
    describe_lines File.readlines(File.dirname(__FILE__) + "/parser_should_not_match.txt"), nil
  end
end