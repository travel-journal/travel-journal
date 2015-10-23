Rails.application.routes.draw do 
  root to: "users#root"

  #get '/users/sign_in', to: 'devise/sessions#new', as: 'new_user_session'
  #get '/users/password/new', to: 'devise/passwords#new', as: 'new_user_password'
  #get '/users/password/edit', to: 'devise/passwords#edit', as: 'edit_user_password'
  #get '/users/sign_up', to: 'devise/registrations#new', as: 'new_user_registration'
  #get '/users/edit', to: 'devise/registrations#edit', as: 'edit_user_registration' 
  
  # it skips these and goes to the api/ routes because of the named helpers
  # can't override named helpers so need to change the calls in the views
  get '/users/sign_in', to: 'devise/sessions#new'
  get '/users/password/new', to: 'devise/passwords#new'
  get '/users/password/edit', to: 'devise/passwords#edit'
  get '/users/sign_up', to: 'devise/registrations#new'
  get '/users/edit', to: 'devise/registrations#edit'

  # new and edit return html pages with forms
  # they don't interact with models so they don't get /api prefix
  scope 'api', except: [:new, :edit] do
    devise_for :users
    #resources :users
    resources :trips
    resources :posts  
  end
  
  # built-in index and show routes should be used to get data from database
  # and respond with it
  get '/trips/new', to: 'trips#new'
  get '/trips/:id/edit', to: 'trips#edit'
  get '/posts/new', to: 'postss#new'
  get '/posts/:id/edit', to: 'posts#edit'





  post '/posts/:id/like_post' => 'posts#like_post', as: 'like_post'# constraints: {:id => /[^\/]+/}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
   
  
end
