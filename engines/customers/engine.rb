require "../base/engine"

module Customers
  class Engine < ::Rails::Engine
    include Base::FlatEngine
  end
end
