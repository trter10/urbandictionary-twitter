require File.dirname(__FILE__) + '/../lib/responder'

describe Responder do
  before { ENV["UPDATE_TWITTER"] = "true" }
  after { Airbrake.sender.collected.should == [] }
  
  it "responds to a user" do
    Object.stub(:puts)
    Twitter.should_receive(:update).with("@: Bootylicious: Some strange word that urban dictionary always wants us to search for.... http://bootylicious.urbanup.com/6050210", in_reply_to_status_id: 1)
    Responder.respond(Twitter::Status.new(id: 1, text: "define bootylicious"))
  end
end