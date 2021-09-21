Rails.application.routes.draw do

  root to: 'homes#top'
  get 'about'=> 'homes#about'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books, only: [:create, :index, :show, :destroy]
  resources :users, only: [:show, :index, :edit, :create, :update]

end
