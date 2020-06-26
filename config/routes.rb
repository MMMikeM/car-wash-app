Rails.application.routes.draw do
  resources :wash_types
  devise_for :users
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "branches#index"
  resources :branches, only: [:index, :show] do
    resources :customers, only: [:index, :new, :show] do
      resources :washes, only: [:new, :create]
    end
  end
end
