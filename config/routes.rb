Rails.application.routes.draw do
  # Статичні сторінки
  root 'pages#home'
  get 'about', to: 'pages#about'
  get 'support', to: 'pages#support'
  post 'support', to: 'pages#support_result'
  
  resources :users do
    collection do
      get 'registration_params', to: 'users#registration_params'
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :transfers do
    member do
      patch :complete
      patch :cancel
    end
  end
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
