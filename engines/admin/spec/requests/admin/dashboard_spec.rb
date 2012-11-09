require 'spec_helper'

describe "The admin dashboard" do
  it "renders successfully" do
    visit "/admin"
    page.should have_content("admin")
  end
end
