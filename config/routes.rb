Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'locations/new'

  get 'locations/show'

  get 'sessions/new'

  get 'users/new'

  root 'static_pages#home'
  get 'help' => "static_pages#help"
  get "home_create" => "static_pages#create_log"
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'location_request' => 'locations#new'
  post 'location_request' => "locations#create"
  get 'directory' => 'locations#index'
  post 'logs/create'
  get 'log_map' => 'static_pages#logmap'


  resources :users
  resources :locations
  resources :logs, only: [:show, :create, :destroy] do
    member do
      put "like", to: "logs#upvote"
      put "dislike", to: "logs#downvote"
      put "cancel", to: "logs#unvote"
    end
  end
  resources :comments

  resources :password_resets,  only: [:new, :create, :edit, :update] 
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
