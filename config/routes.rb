Rails.application.routes.draw do
  devise_for :users
  root 'centers#index' 

  get '/centers' => 'centers#index'
  get '/centers/:id' => 'centers#show'

  post '/search' => 'centers#search'

  get '/images/new' => 'images#new'
  post '/images' => 'images#create'
  delete '/images/:id' => 'images#destroy'

end
