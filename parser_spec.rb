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
    describe_lines <<-END, "hand job"
      what does hand job mean?
      what the fuck is 'hand job'?
      what the hell is 'hand job'?
      whut does hand job mean?
      wut does hand job mean?
      what does "hand job" mean?
      what does "hand job" mean
      what does 'hand job' mean?
      what does 'hand job' really mean?
      what does 'hand job' even mean?
      what the fuck does 'hand job' mean?
      what the FUCK does 'hand job' mean?
      what the hell does 'hand job' mean?
      what the shit does 'hand job' mean?
      @urbandictionary what is 'hand job'?
      @UrbanDictionary what is 'hand job'?
      @urbandictionary what does 'hand job' mean?
      @urbandictionary hand job
      @urbandictionary 'hand job'
      @urbandictionary "hand job"
      @UrbanDictionary hand job
      What The Fuck Does hand job mean?
      hand job #urbandictionary
      hand job #UrbanDictionary
      #urbandictionary hand job
      define hand job
      DEFINE hand job
      define 'hand job'
    END
  end

  describe "shouldn't match" do
    describe_lines [
      "@animullcrackers \nWhat is this",
      "@animullcrackers \nWhat does this mean"
    ], nil
    
    describe_lines <<-END, nil
      what is hand job?
      what is hand job
      what IS hand job?
      what is hand job ?
      wut is hand job ?
      whut is hand job ?
      wtf is hand job
      what is a hand job?
      what is an hand job?
      what is "hand job"?
      what is 'hand job'?
      what is hand job anyway?
      what does it mean?
      what does it even mean?
      what does it all mean?
      what does that mean?
      what does that even mean?
      what does that really mean?
      what is IT?
      wtf is good
      what is air
      what is today?
      what is happening?
      what is going on?
      what is up
      WHAT IS THIS
      @nobody whatever
      xoxo @urbandictionary xoxo
      Omg my mom says "what does 69 mean " and my brothers explaining it to her but it's totally wrong lmaoo..
    END
  end
end