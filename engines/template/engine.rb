require_relative "../base/engine"

module Template
  class Engine < ::Rails::Engine
    include Base::FlatEngine
  end
end
