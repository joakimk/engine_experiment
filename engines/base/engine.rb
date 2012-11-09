require_relative "lib/base/flat_engine"

module Base
  class Engine < ::Rails::Engine
    include Base::FlatEngine
  end
end
