Rails.application.routes.draw do
  resources :wash_types
  resources :system_users, as: :system_users
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "dashboard#index"
end
