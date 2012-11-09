Dummy::Application.routes.draw do
  mount Public::Engine, :at => "/"
  mount Admin::Engine, :at => "/admin"
end
