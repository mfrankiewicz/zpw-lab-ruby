Rails.application.routes.draw do
  get 'login/index'

  get 'login/login'

  get 'index/index'

  resources :tickets
  root :to => "index#index"
  resources :events
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
