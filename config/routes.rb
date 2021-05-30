Rails.application.routes.draw do
  
  get 'users/show'
  devise_for :users
  root 'home#home'
  get 'home/about'
  get 'home/help'
  get 'home/contact'
  resources :users, only: :show
  resources :trip_statements, shallow: true do
    patch 'submit', on: :member
    collection do
      get 'approved'
      get :denied
    end
    resources :expences
    resources :approval, only: [:index, :new, :create, :edit, :update, :destroy] do
      collection do
        get 'approved'
        get :denied
      end
    end
  end
  get 'approval/index' => 'approval#index'
  get 'approval/approved' => 'approval#approved'
  get 'approval/denied' => 'approval#denied'
  # post 'trip_statements/:id/submit', to: 'trip_statements#update_submit'
  # get 'trip_statements/:id/update' => 'trip_statement#update'
end
