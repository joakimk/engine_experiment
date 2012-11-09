module Customers
  class Customer < ActiveRecord::Base
    attr_accessible :name

    def name
      Base::Formatter.format read_attribute(:name)
    end
  end
end
