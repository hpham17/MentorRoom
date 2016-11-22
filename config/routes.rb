Rails.application.routes.draw do
  devise_scope :user do
    get '/users' => 'users/sessions#index', as: 'users'
    get '/user/:id' => 'users/sessions#show', as: 'user'
    get '/admin' => 'users/sessions#admin', as: 'admin'
    get '/mentor' => 'users/sessions#mentor', as: 'mentor'
    get '/setup' => 'users/registrations#setup'
    patch '/update' => 'users/registrations#update'
    post '/skill' => 'users/sessions#skill'
    post '/help' => 'users/sessions#help'
    delete '/skill' => 'users/sessions#destroy_skill'
  end
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions', omniauth_callbacks: 'omniauth_callbacks' }
  root "home#index"
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  get '/direct_messages' => 'direct_messages#index'
  post '/direct_messages/:id' => 'direct_messages#create'
  resources :mentorships, only: [:create, :update]
  resources :chatrooms, param: :slug
  resources :messages

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
