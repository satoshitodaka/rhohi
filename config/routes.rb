Rails.application.routes.draw do
  get 'approval/index' => 'approval#index'
  devise_for :users
  root 'home#home'
  get 'home/about'
  get 'home/help'
  get 'home/contact'
  resources :trip_statements, shallow: true do
    resources :expences
    resources :approval, only: [:index, :create, :edit, :update, :destroy]
  end
end
