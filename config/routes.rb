Rails.application.routes.draw do
  
 
  # devise_for :users, controllers: {
  #   invitations: 'devise/invitations'
  # }
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }

  devise_scope :user do
    get 'users/:id/edit' => 'users/registrations#edit', as: :edit_other_user_registration
    match 'users/:id', to: 'users/registrations#update', via: [:patch, :put], as: :other_user_registration
  end

  root 'home#home'
  get 'home/about'
  get 'home/help'
  get 'home/contact'
  resources :users, only: [:show, :index] do
    patch 'invite', on: :member
  end
  resources :trip_statements, shallow: true do
    patch 'submit', on: :member
    collection do
      get 'approved'
      get :denied
    end
    resources :expences
    resources :approvals, only: [:index, :new, :create, :edit, :update, :destroy] do
      collection do
        get 'approved'
        get :denied
      end
    end
  end
  get 'approvals/index' => 'approvals#index'
  get 'approvals/approved' => 'approvals#approved'
  get 'approvals/denied' => 'approvals#denied'
  # post 'trip_statements/:id/submit', to: 'trip_statements#update_submit'
  # get 'trip_statements/:id/update' => 'trip_statement#update'
end
