Rails.application.routes.draw do
  devise_scope :user do
    get '/users' => 'users/sessions#index', as: 'users'
    get '/admin' => 'users/sessions#admin', as: 'admin'
    get '/mentor' => 'users/sessions#mentor', as: 'mentor'
  end
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  root "home#index"
  get '/direct_messages' => 'direct_messages#index'
  post '/direct_messages/:id' => 'direct_messages#create'
  resources :mentorships, only: [:create, :update]
  resources :chatrooms, param: :slug
  resources :messages

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
