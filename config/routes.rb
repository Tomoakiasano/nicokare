Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, :controllers => {
    :sessions      => "users/sessions",
    :registrations => "users/registrations",
    :passwords     => "users/passwords",
    # :omniauth_callbacks => "users/omniauth_callbacks"
  }
  resources :users, :only => [:index, :show]
  # devise_for :users

  post '/comments/create'

end
