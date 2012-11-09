Dummy::Application.routes.draw do
  mount Public::Engine, :at => "/"
  mount Admin::Engine, :at => "/admin"
  mount Cms::Engine, :at => "/admin"
end
