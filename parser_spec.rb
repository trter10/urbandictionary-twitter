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
    describe_lines <<-END, "X Y"
      what does X Y mean?
      what is X Y?
      what is X Y
      what IS X Y?
      what is X Y ?
      wut is X Y ?
      whut is X Y ?
      wtf is X Y
      what is a X Y?
      what is an X Y?
      what is X Y anyway?
      what is "X Y"?
      what is 'X Y'?
      what the fuck is 'X Y'?
      what the hell is 'X Y'?
      whut does X Y mean?
      wut does X Y mean?
      what does "X Y" mean?
      what does "X Y" mean
      what does 'X Y' mean?
      what does 'X Y' really mean?
      what does 'X Y' even mean?
      what the fuck does 'X Y' mean?
      what the FUCK does 'X Y' mean?
      what the hell does 'X Y' mean?
      what the shit does 'X Y' mean?
      @urbandictionary what is 'X Y'?
      @UrbanDictionary what is 'X Y'?
      @urbandictionary what does 'X Y' mean?
      @urbandictionary X Y
      @urbandictionary 'X Y'
      @urbandictionary "X Y"
      @UrbanDictionary X Y
      What The Fuck Does X Y mean?
      X Y #urbandictionary
      X Y #UrbanDictionary
      #urbandictionary X Y
    END
  end

  describe "shouldn't match" do
    describe_lines [
      "@animullcrackers \nWhat is this",
      "@animullcrackers \nWhat does this mean"
    ], nil
    
    describe_lines <<-END, nil
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