Rails.application.routes.draw do
  get 'posts/index'
  get "posts/new" => "posts#new"

  root "home#top"
  
  get "/new" => "users#new" 
  post "/users/create" => "users#create"
  get "/users/index" => "users#index"
  get "/users/:id" => "users#show"
  get "/users/:id/edit" => "users#edit"
  post "/users/:id/update" => "users#update"
  # For de/tails on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
