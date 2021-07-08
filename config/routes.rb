Rails.application.routes.draw do

  root 'home#home'
  get 'home/about'
  get 'home/help'
  get 'home/contact'
  
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
  }

  devise_scope :user do
    get 'users/:id/edit' => 'users/registrations#edit', as: :edit_other_user_registration
    match 'users/:id', to: 'users/registrations#update', via: [:patch, :put], as: :other_user_registration
    # get 'sign_in', :to => 'users/sessions#new'
    # get 'sign_out', :to => 'users/sessions#destroy'
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
    post 'users/guest_admin_sign_in', to: 'users/sessions#new_admin_guest'
  end

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
  post 'trip_statements/:trip_statement_id/deny' => 'approvals#deny', as: :deny_approval
end
