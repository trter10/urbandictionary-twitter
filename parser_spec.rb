require './parser'

describe Parser do
  MATCHES = <<-END
    what does X Y mean?
    what is X Y?
    what IS X Y?
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
  END

  context "matches" do
    MATCHES.each_line do |line|
      line.strip!
      it line.inspect do
        Parser.parse(line).should == "X Y"
      end
    end
  end

  NO_MATCHES = <<-END
    what does it mean?
    what does it even mean?
    what does it all mean?
  END

  context "doesn't match" do
    NO_MATCHES.each_line do |line|
      line.strip!
      it line.inspect do
        Parser.parse(line).should be_nil
      end
    end
  end
  
  # it { Parser.parse("this means nothing").should be_nil }
  # 
  # describe "what does" do
  #   it { Parser.parse("what does bootylicious mean?").should == "bootylicious" }
  #   it { Parser.parse("what does \"bootylicious\" mean?").should == "bootylicious" }
  #   it { Parser.parse("what does it mean?").should be_nil }
  #   it { Parser.parse("what does that mean?").should be_nil }
  #   it { Parser.parse("what does THAT mean?").should be_nil }
  #   it { Parser.parse("what does that even mean?").should be_nil }
  #   it { Parser.parse("what does this mean?").should be_nil }
  # end
  # 
  # describe "what is" do
  #   it { Parser.parse("what is an elephant?").should == "elephant" }
  #   it { Parser.parse("what is a elephant?").should == "elephant" }
  #   it { Parser.parse("what is a \"big elephant\"?").should == "big elephant" }
  #   it { Parser.parse("@urbandictionary big elephant").should == "big elephant" }
  #   xit { Parser.parse("Laughing like shit, corny af RT @OhhSoo_COLD: What Does Lls Mean ?").should be_nil }
  # end
  # 
  # describe "define" do
  #   it { Parser.parse("Define \"pig sty\".").should == "pig sty" }
  #   it { Parser.parse("accept no one's definition of your life. define yourself.").should be_nil }
  # end
  # 
  # describe "what the fuck/hell is" do
  #   it { Parser.parse("what the fuck is an elephant?").should == "elephant" }
  #   it { Parser.parse("@urbandictionary what the fuck is an elephant?").should == "elephant" }
  #   it { Parser.parse("What The Fuck Does MLRT mean?").should == "MLRT" }
  #   it { Parser.parse("what the hell is a elephant?").should == "elephant" }
  #   it { Parser.parse("@jayl3n FUCK what does two strands mean in the first place").should be_nil }
  #   it { Parser.parse("FUCK what does two strands mean in the first place").should == "two strands" }
  #   it { Parser.parse("What does \"Champion of the Earth\" actually mean/what the fuck do they do?!").should == "Champion of the Earth" }
  #   it { Parser.parse("Omg my mom says \"what does 69 mean \" and my brothers explaining it to her but it's totally wrong lmaoo..").should be_nil }
  # end
end
