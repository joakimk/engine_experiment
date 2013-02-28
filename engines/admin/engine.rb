module Admin
  class Engine < ::Rails::Engine
    include Base::FlatEngine

    config.after_initialize do
      Rails.application.config.assets.precompile += %w{admin/test.css}
    end
  end
end
