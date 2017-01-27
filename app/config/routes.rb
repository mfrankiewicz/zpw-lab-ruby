Rails.application.routes.draw do
  get 'index/index'

  resources :tickets
  root :to => "index#index"
  resources :events, :only => [:index, :new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
