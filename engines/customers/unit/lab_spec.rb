$: << "lib"
require "lab"

describe Lab, "foo" do
  1000.times do
    it "works" do
      Lab.new.foo.should == 4
    end
  end
end
