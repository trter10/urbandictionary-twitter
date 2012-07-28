require './formatter'

describe Formatter do
  it {
    input = {
               "defid" => 385099,
                "word" => "69",
              "author" => "starflier",
           "permalink" => "http://69.urbanup.com/385099",
          "definition" => "Simultaneous oral sex. Can be practised by M+M, M+F or F+F.\r\n\r\nThe reference is that the numerals 6 and 9 are inverted versions of each other, reflecting the physical position that the couple must adopt when engaged in this sexual practice.",
             "example" => "The two girls were in a 69, licking each other's pussies.",
           "thumbs_up" => 11307,
         "thumbs_down" => 4299,
        "current_vote" => ""
    }
    
    actual = Formatter.format(input)
    actual.should == "69: Simultaneous oral sex. Can be practised by M+M, M+F or F+F. The reference is that the numerals 6 and 9 a... http://69.urbanup.com/385099"
  }
end