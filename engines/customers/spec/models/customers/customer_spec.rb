require 'spec_helper'

describe Customers::Customer do
  it "likes capslock" do
    described_class.new(name: "joe").name.should == "JOE"
  end
end
