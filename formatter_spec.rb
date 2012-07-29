require './formatter'

describe Formatter do
  it {
    input = {
               "defid" => 385099,
                "word" => "69",
              "author" => "starflier",
           "permalink" => "http://69.urbanup.com/385099",
          "definition" => "Simultaneous [oral sex]. Can be practised by M+M, M+F or F+F.\r\n\r\nThe reference is that the numerals 6 and 9 are inverted versions of each other, reflecting the physical position that the couple must adopt when engaged in this sexual practice.",
             "example" => "The two girls were in a 69, licking each other's pussies.",
           "thumbs_up" => 11307,
         "thumbs_down" => 4299,
        "current_vote" => ""
    }
    
    actual = Formatter.format("leonjohnmurphy", input)
    actual.should == "@leonjohnmurphy: 69: Simultaneous oral sex. Can be practised by M+M, M+F or F+F. The reference is that the n... http://69.urbanup.com/385099"
  }
  
  it {
    input = {
        "author" => "Renato", 
        "current_vote" => "", 
        "defid" => 1071520, 
        "definition" => "A country   I've never heard of.", 
        "example" => "Do they speak English in \"what\"?", 
        "permalink" => "http://what.urbanup.com/1071520", 
        "thumbs_down" => 317, 
        "thumbs_up" => 1323, 
        "word" => "what"
    }
    
    actual = Formatter.format("leonjohnmurphy", input)
    actual.should == "@leonjohnmurphy: what: A country I've never heard of. http://what.urbanup.com/1071520"
  }
end