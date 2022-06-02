Rails.application.routes.draw do

  devise_for :users
  #フォロー機能をネスト
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  #「Userがいいねしたのは、どの投稿なのか」を分かるようにするためネスト
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
