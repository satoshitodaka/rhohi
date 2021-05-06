Rails.application.routes.draw do
  get 'approval/index' => 'approval#index'
  # get 'approval/show'
  # get 'approval/create'
  # get 'approval/edit'
  # get 'approval/update'
  # get 'approval/destroy'
  devise_for :users
  root 'home#home'
  get 'home/about'
  get 'home/help'
  resources :trip_statements, shallow: true do
    resources :expences
    resources :approval, only: [:new, :index, :show, :create, :edit, :update, :destroy]
  end
end
