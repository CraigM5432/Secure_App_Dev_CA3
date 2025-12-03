Rails.application.routes.draw do
# Homepage → posts index
  root "posts#index"

# registration
  resources :users, only: [:new, :create, :show, :edit, :update]

# login / logout
  get    "login",  to: "sessions#new"
  post   "login",  to: "sessions#create"
  delete "logout", to: "sessions#destroy"

# posts & nested comments
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
end

