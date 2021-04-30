Rails.application.routes.draw do
  devise_for :users
  root 'home#home'
  get 'home/about'
  get 'home/help'
  # get 'trip_statements/new', to: 'trip_statements#create'
  resources :trip_statements
end
