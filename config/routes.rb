Rails.application.routes.draw do
  devise_scope :user do
    get '/users' => 'users/sessions#index', as: 'users'
  end
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  root "home#index"

  resources :chatrooms, param: :slug
  resources :messages

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
