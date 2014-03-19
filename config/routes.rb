Server::Application.routes.draw do
  root to: "admin/dashboard#index"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :feed, only: [:show]
      resources :search, only: [:show]
      resources :device_tokens, only: [:create, :destroy]
      resources :followers, only: [:show]
      resources :is_friends, only: [:show]
      resources :attendees, only: [:show, :create, :update, :destroy]
      resources :friendships, only: [:show, :create, :destroy]
      resources :events, only: [:show, :create, :update, :destroy]
      post '/nearby_eveneants', to: 'nearby_events#nearby'
      resources :users, except: :show
      get 'users/:uid', to: 'users#show'
    end
  end
  post '/admin/notifications',to: 'admin/notifications#notify'
end
