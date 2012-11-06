require 'spec_helper'

describe Customer do
  it "likes capslock" do
    Customer.new(name: "joe").name.should == "JOE"
  end
end
