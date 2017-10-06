Rails.application.routes.draw do
  default_url_options host: AppConfig.domain

  resources :skills
  resources :topics do
    resources :skills
    resources :supports
  end
  resources :users
  resources :supports do
    resources :comments, only: :create
    member do
      post :finish
      post :skip
      post :ack
    end
  end

  root :to => 'home#index'

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'

end
