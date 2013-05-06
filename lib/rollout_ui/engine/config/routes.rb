RolloutUi::Engine.routes.draw do
  resources :features, :only => [:index, :update, :create]
  resources :groups, :only => [:create]

  root :to => "features#index"
end
