require 'spec_helper'

describe Formatter do
  it "is some kind of low level tool" do
    Formatter.format('foo').should == 'FOO'
  end
end
