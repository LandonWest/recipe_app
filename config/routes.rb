Rails.application.routes.draw do

  devise_for :users
  root "site#index"

  resources :recipes

  resources :user, only: :show

end
