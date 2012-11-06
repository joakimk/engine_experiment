class Customer < ActiveRecord::Base
  attr_accessible :name

  def name
    Formatter.format read_attribute(:name)
  end
end
