Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated :user, ->(user) { user.has_role? :supervisor } do
      root to: 'supervisor/dashboard#index', as: :supervisor_dashboard
    end

    authenticated :user do
      root to: 'main#dashboard', as: :dashboard
    end

    unauthenticated do
      root to: 'devise/sessions#new', as: :login_root
    end
  end

  scope module: :supervisor do
    root to: "dashboard#edit"
  end

  scope module: :profile do
    resources :user, only: %i[update, index]
  end
end
