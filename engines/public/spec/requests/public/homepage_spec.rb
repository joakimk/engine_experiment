require 'spec_helper'

describe "The homepage" do
  it "renders successfully" do
    visit "/"
    page.should have_content("TEST")
  end
end
