module Cms
  class CampaignsController < Admin::BaseController
    def index
      @campaigns = Content::Campaign.all
    end
  end
end
