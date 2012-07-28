require './parser'

describe Parser do
  it { Parser.parse("this means nothing").should be_nil }

  describe "what does" do
    it { Parser.parse("what does bootylicious mean?").should == "bootylicious" }
    it { Parser.parse("what does \"bootylicious\" mean?").should == "bootylicious" }
    it { Parser.parse("what does it mean?").should be_nil }
    it { Parser.parse("what does that mean?").should be_nil }
    it { Parser.parse("what does THAT mean?").should be_nil }
    it { Parser.parse("what does that even mean?").should be_nil }
    it { Parser.parse("what does this mean?").should be_nil }
  end
  
  describe "what is" do
    it { Parser.parse("what is an elephant?").should == "elephant" }
    it { Parser.parse("what is a elephant?").should == "elephant" }
    it { Parser.parse("what is a \"big elephant\"?").should == "big elephant" }
  end
  
  describe "define" do
    it { Parser.parse("Define \"pig sty\".").should == "pig sty" }
    it { Parser.parse("accept no one's definition of your life. define yourself.").should be_nil }
  end
  
  describe "what the fuck/hell is" do
    it { Parser.parse("what the fuck is an elephant?").should == "elephant" }
    it { Parser.parse("What The Fuck Does MLRT mean?").should == "MLRT" }
    it { Parser.parse("what the hell is a elephant?").should == "elephant" }
    it { Parser.parse("@jayl3n FUCK what does two strands mean in the first place").should be_nil }
    it { Parser.parse("FUCK what does two strands mean in the first place").should == "two strands" }
    it { Parser.parse("What does \"Champion of the Earth\" actually mean/what the fuck do they do?!").should == "Champion of the Earth" }
  end
end
