Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :user, only: [:new, :create, :index, :show] do 
    resources :subs, only: [:edit, :update, :destroy]

  end

  resources :subs, only: [:new, :create, :index, :show] 
  resources :posts, only: [:new, :create, :destroy, :show, :edit, :update] do
    resources :comments, only: [:new]
  end

  resources :comments, only: [:create, :show] 
  resource :session, only: [:new, :create, :destroy]
end
