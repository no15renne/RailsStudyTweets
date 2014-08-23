Rails.application.routes.draw do
root 'tweets#index' # ログイン画面をルートにする
get '/tweets' => 'tweets#index'
#post 'devise/registarations/' => 'tweets#index'

  devise_for :admin_users
 
	resources :tweets
 # get 'tweets/index'
 # get 'tweets/show/:username' => "tweets#show"
 # get 'tweets/new/:username' => "tweets#new"
 # post "tweets/create/:username" => "tweets#create"
  get 'tweets/create_follow/:id' => 'tweets#create_follow'
  get 'tweets/remove_follow/:id' => 'tweets#remove_follow'
  get 'users/show/:username' => "users#show"

#404, 500
#  get '*not_found' => 'application#routing_error'
#  post '*not_found' => 'application#routing_error'

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
