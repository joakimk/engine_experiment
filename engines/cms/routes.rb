Cms::Engine.routes.draw do
  scope module: :cms do
    resources :campaigns, only: [ :index ]
  end
end
