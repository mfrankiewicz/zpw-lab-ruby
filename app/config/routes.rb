Rails.application.routes.draw do
  get 'login/index'

  get 'login/login'

  get 'index/index'

  get 'user/index'

  post 'user/login'

  resources :tickets
  root :to => "index#index"
  resources :events
  resources :users, only: [:index, :login], path_names: {index: 'login'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
