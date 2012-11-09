module Public
  class HomePageController < ActionController::Base
    def index
      @customer = Customer.new(name: 'test')
    end
  end
end
