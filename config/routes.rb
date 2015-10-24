Rails.application.routes.draw do 
  root to: "users#root"
  devise_for :users, skip: :all
  # had to manually make these to prefix only some with /api
  devise_scope :user do
    get '/users/sign_in', to: 'devise/sessions#new', as: 'new_user_session'
    post '/api/users/sign_in', to: 'devise/sessions#create', as: 'user_session'
    delete '/api/users/sign_out', to: 'devise/sessions#destroy', as: 'destroy_user_session'
    post '/api/users/password', to: 'devise/passwords#create', as: 'user_password'
    get '/users/password/new', to: 'devise/passwords#new', as: 'new_user_password'
    get '/users/password/edit', to: 'devise/passwords#edit', as: 'edit_user_password'
    patch '/api/users/password', to: 'devise/passwords#update'
    put '/api/users/password', to: 'devise/passwords#update'
    delete 'api/users/cancel', to: 'devise/registrations#cancel', as: 'cancel_user_registration'
    post '/api/users', to: 'devise/registrations#create', as: 'user_registration'
    get '/users/sign_up', to: 'devise/registrations#new', as: 'new_user_registration'
    get '/users/edit', to: 'devise/registrations#edit', as: 'edit_user_registration'
    patch '/api/users', to: 'devise/registrations#update'    
    put '/api/users', to: 'devise/registrations#update', as: 'update_user_registration'
    delete '/api/users', to: 'devise/registrations#destroy'
  end
  

  # built-in index and show routes should be used to get data from database
  # and respond with it

  get '/api/trips', to: 'trips#index', as: 'trips'
  post '/api/trips', to: 'trips#create'
  get '/api/trips/:id', to: 'trips#show', as: 'trip'
  patch '/api/trips/:id', to: 'trips#update'
  put '/api/trips/:id', to: 'trips#update'
  delete '/api/trips/:id', to: 'trips#destroy'
  get '/api/posts', to: 'posts#index', as: 'posts'
  post '/api/posts', to: 'posts#create'
  get '/posts/:trip_id/:date', to: 'posts#show', as: 'day_posts'
  patch '/api/posts/:id', to: 'posts#update'
  put '/api/posts/:id', to: 'posts#update'
  delete '/api/posts/:id', to: 'posts#delete'










  get '/trips/new', to: 'trips#new', as: 'new_trip'
  get '/trips/:id/edit', to: 'trips#edit', as: 'edit_trip'

  get '/trips/:trip_id/posts/new/', to: 'posts#new', as: 'new_post'
  get '/posts/:id/edit', to: 'posts#edit', as: 'edit_post'




  post '/posts/:id/like_post' => 'posts#like_post', as: 'like_post'# constraints: {:id => /[^\/]+/}

end
