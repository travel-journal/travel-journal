Rails.application.routes.draw do 
  # resources :comments
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
  get '/api/posts/:id', to: 'posts#show', as: 'post'  
  get '/api/trips/:trip_id/posts', to: 'posts#show', as: 'day_posts'
  patch '/api/posts/:id', to: 'posts#update'
  put '/api/posts/:id', to: 'posts#update', as: 'update_post'
  delete '/api/posts/:id', to: 'posts#destroy'



  get '/trips/new', to: 'trips#new', as: 'new_trip'
  get '/trips/:id/edit', to: 'trips#edit', as: 'edit_trip'

  get '/trips/:trip_id/posts/new/', to: 'posts#new', as: 'new_post'
  get '/posts/:id/edit', to: 'posts#edit', as: 'edit_post'

  post '/api/posts/:id/like_post' => 'posts#like_post', as: 'like_post'# constraints: {:id => /[^\/]+/}
  post '/api/posts/:id/add_comment' => 'posts#add_comment', as: 'add_comment'


  post '/api/posts/:post_id/comments' => 'comments#create'
  get '/api/posts/:post_id/comments' => 'comments#index', as: 'post_comments'
  delete '/api/posts/:post_id/comments/:id' => 'comments#destroy', as: 'destroy_comment'
  get '/posts/:post_id/comments/new', to: 'comments#new', as: 'new_post_comment'
  put '/api/posts/:post_id/comments/:id', to: 'comments#update', as: 'update_comment'



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase


end
