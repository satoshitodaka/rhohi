Rails.application.routes.draw do
  
  devise_for :users
  root 'home#home'
  get 'home/about'
  get 'home/help'
  get 'home/contact'
  resources :trip_statements, shallow: true do
    patch 'submit', on: :member
    resources :expences
    resources :approval, only: [:index, :new, :create, :edit, :update, :destroy]
  end
  get 'approval/index' => 'approval#index'
  # post 'trip_statements/:id/submit', to: 'trip_statements#update_submit'
  # get 'trip_statements/:id/update' => 'trip_statement#update'
end
