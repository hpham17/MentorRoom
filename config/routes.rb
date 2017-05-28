Rails.application.routes.draw do
  authenticated :user do
    devise_scope :user do
      root "organizations#show"
    end
  end
  
  root "home#index"

  devise_scope :user do
    get '/users' => 'users/sessions#index', as: 'users'
    get '/user/:id' => 'users/sessions#show', as: 'user'
    get '/admin' => 'users/sessions#admin', as: 'admin'
    get '/mentor' => 'users/sessions#mentor', as: 'mentor'
    post '/users/friend_request/:id' => 'users/sessions#friend_request', as: 'friend_request'
    post '/users/decline_request/:id' => 'users/sessions#decline_request', as: 'decline_request'
    post '/users/accept_request/:id' => 'users/sessions#accept_request', as: 'accept_request'
    get '/setup' => 'users/registrations#setup', as: 'setup'
    get '/edit_picture' => 'users/registrations#edit_picture', as: 'edit_picture'
    patch '/user/:id' => 'users/registrations#update_picture'
    patch '/update' => 'users/registrations#update'
    post '/tag' => 'users/sessions#tag'
    delete '/tag' => 'users/sessions#destroy_tag'
    post '/status' => 'users/sessions#status'
  end

  scope :api, module: 'api' do
    resources :subscriptions, only: [:create, :destroy]
  end

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions', omniauth_callbacks: 'omniauth_callbacks', confirmations: 'users/confirmations' }
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  get '/direct_messages' => 'direct_messages#index'
  post '/direct_messages/:id' => 'direct_messages#create'
  resources :mentorships, only: [:create, :update]
  resources :chatrooms, param: :slug
  resources :organizations
  resources :messages
  resources :invites
  post '/member_requests' => 'member_requests#create'
  post 'accept_member_request' => 'organizations#accept_request'
  post '/notifications/clear' => 'notifications#clear'
  resources :events
  resources :flash_sessions
  resources :attachments, only: [:new, :create]
  post '/star', to: 'stars#star'
  delete '/unstar', to: 'stars#unstar'
  post '/upload', to: 'home#upload'
  post '/upload_logo', to: 'organizations#upload'


  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
