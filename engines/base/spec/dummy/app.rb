require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('Gemfile', __FILE__)

require 'bundler/setup'
require 'rails/all'

Bundler.require(*Rails.groups(:assets => %w(development test)))

require_relative "../../../../lib/engine_loader"
EngineLoader.load

puts "Loaded engines in dummy app: #{EngineLoader.loaded_engines.join(', ')}."

module Dummy
  class Application < Rails::Application
    config.root = File.dirname(__FILE__)
    config.paths["config/database"] = "#{config.root}/database.yml"
    config.railties_order = [ EngineLoader.loaded_engine_classes, :main_app, :all ].flatten
    config.active_support.deprecation = :stderr
    config.secret_token = '26de0653e0461dad61dd9422cc2705de61a3b73c8ecb873b5625d0bd6a98c94b3431af8fefca80f226c3fb9fbd6849115a2b0bb8ea24b605813160fa86668be6'
    config.cache_classes = true
    config.serve_static_assets = true
    config.static_cache_control = "public, max-age=3600"
    config.whiny_nils = true
    config.consider_all_requests_local       = true
    config.action_controller.perform_caching = false
    config.action_dispatch.show_exceptions = false
    config.action_controller.allow_forgery_protection    = false
    #config.action_mailer.delivery_method = :test
    config.active_record.mass_assignment_sanitizer = :strict

    config.after_initialize do
      routes.draw do
        mount Public::Engine, :at => "/"     if EngineLoader.loaded?(:public)
        mount Admin::Engine, :at => "/admin" if EngineLoader.loaded?(:admin)
        mount Cms::Engine, :at => "/admin"   if EngineLoader.loaded?(:cms)
      end

      I18n.enforce_available_locales = true
    end
  end
end

Dummy::Application.initialize!
