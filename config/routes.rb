Rails.application.routes.draw do
  devise_scope :user do
    get '/users' => 'users/sessions#index', as: 'users'
    get '/user/:id' => 'users/sessions#show', as: 'user'
    get '/admin' => 'users/sessions#admin', as: 'admin'
    get '/mentor' => 'users/sessions#mentor', as: 'mentor'
    get '/setup' => 'users/registrations#setup'
    patch '/update' => 'users/registrations#update'
    post '/tag' => 'users/sessions#tag'
    delete '/tag' => 'users/sessions#destroy_tag'
    post '/status' => 'users/sessions#status'
  end
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions', omniauth_callbacks: 'omniauth_callbacks' }
  root "home#index"
  get '/calendar', to: 'home#calendar'
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  get '/direct_messages' => 'direct_messages#index'
  post '/direct_messages/:id' => 'direct_messages#create'
  resources :mentorships, only: [:create, :update]
  resources :chatrooms, param: :slug
  resources :messages
  post '/notifications/clear' => 'notifications#clear'
  resources :events

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
