module Base
  module FlatEngine
    extend ActiveSupport::Concern

    included do
      paths["app"] << "."
      paths["app/controllers"] << "controllers"
      paths["app/views"] << "views"
      paths["app/helpers"] << "helpers"
      paths["app/models"] << "models"
      paths["app/assets"] << "assets"
      paths["config/routes"] = "routes.rb"
      paths["config/initializers"] << "initializers"
      paths["config/locales"] << "locales"
      config.eager_load_paths.reject! { |path| path.include?("spec") }
      config.i18n.load_path += Dir[File.join(File.dirname(__FILE__), 'locales', '*/*.{rb,yml}').to_s]
    end
  end
end
