require_relative "../base/engine"

module Public
  class Engine < ::Rails::Engine
    include Base::FlatEngine
  end
end
