Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post "sign_in", to: "sessions#create"
      end

      resources :customers
      resources :wash_types
      resources :washes, only: [:create, :destroy]
      resources :vehicles
      resources :system_users
      put '/system_users/:user_id/roles', to: "system_users#update_roles"
    end
  end
end
