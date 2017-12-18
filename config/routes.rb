Rails.application.routes.draw do
  get 'login', to: 'sessions#new', as: :new_session
  post 'sessions', to: 'sessions#create', as: :sessions
  delete 'logout', to: 'sessions#destroy', as: :session

  resources :users
  resources :registrations, only: [:new, :create]

  root to: "users#index"
end
