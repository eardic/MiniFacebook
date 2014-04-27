MiniFacebook::Application.routes.draw do

  get "facebook/get_messages"
  get "facebook/home"
  get "facebook/profile"
  get "facebook/find_friends"
  get "facebook/log_out"
  get "facebook/friend_profile"
  delete "facebook/delete_post"
  post "facebook/add_friend"
  post "facebook/send_message"
  post "facebook/post_text"
  post "facebook/like_post"
  post "facebook/dislike_post"
  post "facebook/add_comment"
  post "facebook/share_post"
  delete "facebook/delete_comment"

  patch "profile/update_basic"
  patch "profile/update_contact"
  post "profile/add_contact"
  patch "profile/update_job"
  post "profile/add_job"
  patch "profile/update_education"
  post "profile/add_education"
  post "profile/upload_photo"
  delete "profile/delete_friend"

  get "login/new"
  post "login/login_try"
  post "login/create"
  get "login/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'login#index'

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
