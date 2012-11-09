require 'spec_helper'

describe Base::Formatter do
  it "is some kind of low level tool" do
    described_class.format('foo').should == 'FOO'
  end
end
