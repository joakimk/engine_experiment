module Customers
  class Engine < ::Rails::Engine
    paths["app"] << "."
    paths["app/controllers"] << "controllers"
    paths["app/views"] << "views"
    paths["app/helpers"] << "helpers"
    paths["app/models"] << "models"
    paths["config/routes"] = "routes.rb"
    paths["config/initializers"] << "initializers"
    paths["config/locales"] << "locales"
    config.eager_load_paths.reject! { |path| path.include?("spec") }
  end
end
