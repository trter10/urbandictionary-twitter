require './parser'

describe Parser do
  MATCHES = <<-END
    what does X Y mean?
    what is X Y?
    what IS X Y?
    what is X Y ?
    what is a X Y?
    what is an X Y?
    what is X Y anyway?
    what is "X Y"?
    what is 'X Y'?
    what the fuck is 'X Y'?
    what the hell is 'X Y'?
    what does "X Y" mean?
    what does 'X Y' mean?
    what does 'X Y' really mean?
    what does 'X Y' even mean?
    what the fuck does 'X Y' mean?
    what the FUCK does 'X Y' mean?
    what the hell does 'X Y' mean?
    what the shit does 'X Y' mean?
    @urbandictionary what is 'X Y'?
    @urbandictionary what does 'X Y' mean?
    @urbandictionary X Y
    @urbandictionary 'X Y'
    @urbandictionary "X Y"
    What The Fuck Does X Y mean?
  END

  NO_MATCHES = <<-END
    what does it mean?
    what does it even mean?
    what does it all mean?
    what does that mean?
    what does that even mean?
    what does that really mean?
    what is IT?
    @nobody whatever
    Omg my mom says "what does 69 mean " and my brothers explaining it to her but it's totally wrong lmaoo..
  END
  
  def self.describe_lines(array, expected)
    array.each_line do |line|
      line.strip!
      it line.inspect do
        Parser.parse(line).should == expected
      end
    end
  end

  describe "matches" do
    describe_lines MATCHES, "X Y"
  end

  describe "doesn't match" do
    describe_lines NO_MATCHES, nil
  end
end