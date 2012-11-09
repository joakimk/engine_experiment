require 'spec_helper'

describe "The campaign editor" do
  it "renders successfully" do
    Content::Campaign.create! title: "Half price this week!"
    visit "/admin/campaigns"
    page.should have_content("campaigns")
    page.should have_content("Half price this week!")
    page.should have_content("USING ADMIN LAYOUT")
  end
end
