Server::Application.routes.draw do
  root to: "admin/dashboard#index"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :feed
      resources :search
      resources :followers
      resources :attendees
      resources :friendships
      resources :events
      resources :users, except: :show
      get 'users/:uid', to: 'users#show'
    end
  end
end
