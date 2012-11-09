module Public
  class HomePageController < ActionController::Base
    def index
      @customer = Customers::Customer.new(name: 'test')
    end
  end
end
