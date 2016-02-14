Rails.application.routes.draw do
  devise_for :users
  root 'centers#index' 

  get '/centers' => 'centers#index'
end
