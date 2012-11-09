require 'spec_helper'

describe "The campaign editor" do
  it "renders successfully" do
    visit "/admin/campaigns"
    page.should have_content("campaigns")
  end
end
