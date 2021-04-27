Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :books
  resources :users,only:[:show,:edit,:update]
  get "users" => "users#index"
  delete "/books" => "books#destroy"
end
