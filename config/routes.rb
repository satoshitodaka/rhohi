Rails.application.routes.draw do
  
  devise_for :users
  root 'home#home'
  get 'home/about'
  get 'home/help'
  get 'home/contact'
  resources :trip_statements, shallow: true do
    resources :expences
    resources :approval, only: [:index, :new, :create, :edit, :update, :destroy]
  end
  get 'approval/index' => 'approval#index'
  # get 'trip_statements/:id/update' => 'trip_statement#update'
end
