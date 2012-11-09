module Public
  class HomePageController < ActionController::Base
    def index
      @customer = Customers::Customer.new(name: 'test')
      @campaigns = Content::Campaign.all
    end
  end
end
