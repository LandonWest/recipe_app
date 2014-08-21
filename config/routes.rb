Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }
  root "site#index"

  resources :recipes

  resources :user, only: :show

end
