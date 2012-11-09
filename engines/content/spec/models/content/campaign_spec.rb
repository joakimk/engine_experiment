require 'spec_helper'

describe Content::Campaign do
  it "can be created" do
    campaign = described_class.new(title: "News")
    campaign.save!
  end
end
