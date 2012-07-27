describe Parser do
  it { Parser.parse("what does bootylicious mean?").should == "bootylicious" }
  it { Parser.parse("this means nothing").should be_nil }
  it { Parser.parse("what does \"bootylicious\" mean?").should == "bootylicious" }
  it { Parser.parse("what does it mean?").should be_nil }
  it { Parser.parse("what does that mean?").should be_nil }
end
