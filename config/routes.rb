Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:index,:show,:edit,:update]
  #「Userがいいねしたのは、どの投稿なのか」を分かるようにするためネスト
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :favorites, only: [:create, :destroy]
  end

  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
