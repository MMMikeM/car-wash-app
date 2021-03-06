Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post "sign_in", to: "sessions#create"
      end

      post "customers/reset_password", to: "customers#reset_password"
      get "customers/duplicates", to: "customers#duplicate_customers"
      get "customers/duplicates/merge", to: "customers#merge_duplicates"
      resources :customers do
        put "update_password", to: "customers#update_password"
      end
      resources :wash_types
      post '/wash_types/bulk_update', to: "wash_types#bulk_update"
      resources :washes, only: [:create, :destroy]
      resources :vehicles
      resources :system_users
      put '/system_users/:user_id/roles', to: "system_users#update_roles"
      get '/reports/washes_report', to: "reports#washes_report"
      get '/reports/user_washes', to: "reports#todays_washes_report"
      get '/reports/washes_daily', to: "reports#washes_daily_report"
      get '/reports/washes_daily_detail', to: "reports#washes_daily_detail_report"
      get '/reports/washes_detail', to: "reports#washes_detail_report"
      get '/reports/insurance', to: "reports#insurance_report"
      get '/reports/active_users', to: "reports#active_users_report"
    end
  end
end
