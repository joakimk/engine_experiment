Dummy::Application.routes.draw do
  mount Public::Engine, :at => "/" if defined?(Public)
  mount Admin::Engine, :at => "/admin" if defined?(Admin)
  mount Cms::Engine, :at => "/admin" if defined?(Cms)
end
