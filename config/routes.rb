Rails.application.routes.draw do
  
  root "home#top"
  
  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"
  
  get "tweets/top" => "tweets#top"
  get "t_user" => "tweets#t_user"
  post "t_user" => "tweets#t_user"

  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"
  get "users/:id/destroy" => "users#destroy"  
  get "users/index" => "users#index"
  post "users/create" => "users#create"
  get "users/new" => "users#new" 
  get "users/:id" => "users#show"
 

  post "login" => "users#login"
  get "login" => "users#login_form"
  get "logout" => "users#logout"
  
  get 'posts/index'
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"
  get "posts/:id" => "posts#show"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"
  
  get "posts/:id/share" => "posts#share"
  
  # For de/tails on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
