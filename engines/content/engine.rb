require_relative "../base/engine"

module Content
  class Engine < ::Rails::Engine
    include Base::FlatEngine
  end
end
