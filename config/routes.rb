Rails.application.routes.draw do
  root 'home#index'

  resources :users
  devise_for :users

end
