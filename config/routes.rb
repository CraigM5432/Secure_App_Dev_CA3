Rails.application.routes.draw do
# Homepage
  root "posts#index" 

#user registration
  resources :users, only: [:new, :create, :show, :edit, :update]

#sessions (login/logout)
  get "login",  to: "sessions#new"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"

#posts + comments
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

#insecure Admin Dashboard
  get "/admin/dashboard", to: "admin#dashboard"
  get "/admin/delete_user/:id", to: "admin#delete_user"
  get "/admin/delete_post/:id", to: "admin#delete_post"
  get "/admin/delete_comment/:id", to: "admin#delete_comment"
end

