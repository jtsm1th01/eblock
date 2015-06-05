Rails.application.routes.draw do

  root 'items#index'
  devise_for :users

  resource :charity
  get 'dashboard' => 'charities#show', as: :dashboard
  
  resources :auctions, only: [:new, :create, :show]
  post 'auctions/wrapup' => 'auctions#wrapup', as: :wrapup
  post 'confirm_payment' => 'payment_notifications#confirm_payment'

  resources :items do
    resources :bids, only: :create
    resources :watch_list_items, only: :create
  end
  resources :watch_list_items, only: [:index, :update, :destroy]

  get 'my_donations' => 'items#show_my_donations', as: :my_donations
  get 'review' => 'items#review' 

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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
