require 'sidekiq/web'

Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do
    authenticated :user, ->(user) { user.role_supervisor? } do
      get 'dashboard', to: "main#dashboard", as: :supervisor_dashboard

      mount Sidekiq::Web => '/sidekiq'
    end

    authenticated :user do
      root to: 'main#dashboard', as: :dashboard
    end

    unauthenticated do
      root to: 'devise/sessions#new', as: :login_root
    end
  end

  namespace :profile do
    resources :user, only: %i[update edit]
  end

  namespace :supervisor do
    resources :users
    resources :products, only: %i[index show update destroy]
  end

  resources :products

  resources :main do
    member do
      put :processing
      put :accept
      put :denied
    end
  end

  root to: "main#dashboard"
end
