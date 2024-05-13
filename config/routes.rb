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
    resources :orders
  end

  resources :orders, only: %i[create] do
    member do
      post :accept
      post :deny
    end
  end

  resources :products

  root to: "main#dashboard"
end
