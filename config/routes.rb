Rails.application.routes.draw do
  
  get 'referrals/index'

  get 'referrals/show'

  get 'referrals/new'

  get 'referrals/create'

  devise_for :users
  root 'centers#index' 

  get '/centers' => 'centers#index'
  get '/centers/:id' => 'centers#show'
  post '/search' => 'centers#search'

  get '/images' => 'images#index'
  get '/images/new' => 'images#new'
  post '/images' => 'images#create'
  get '/images/:id' => 'images#show'
  delete '/images/:id' => 'images#destroy'

  get '/posts' => 'posts#index'
  get 'posts/:id' => 'posts#show'
  get '/posts/new' => 'posts#new'
  post '/posts' => 'posts#create'

  get '/comments' => 'comments#index'
  get '/comments/new' => 'comments#new'
  post '/comments' => 'comments#create'
  get 'comments/:id' => 'comments#show'

end
