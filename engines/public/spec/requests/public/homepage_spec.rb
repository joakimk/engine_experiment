require 'spec_helper'

describe "The homepage" do
  it "renders successfully" do
    Content::Campaign.create! title: "Half price this week!"
    visit "/"
    page.should have_content("Half price this week!")
    page.should have_content("TEST")
  end
end
