Rails.application.routes.draw do

# You can have the root of your site routed with "root"
  root 'login#index'
  
  get  'login' => 'login#index'
  post 'login' => 'login#login'
  get  'logout'  => 'login#logout'
  post  'forgot_password'  => 'login#forgot_password'
  get  'password_reset' => 'login#password_reset'
  post 'password_reset' => 'login#do_reset'
  get  'home' => 'home#index'
  resources :admins
  resources :customers do
    collection { 
      post :import
      get :import_new
      get :edit_all
      get :create_customer
      post :get_customer_list
    }
  end
  resources :customer_types
  resources :user_types do
    collection {
      post :get_user_types
    }
  end
  resources :daycare_departments do
    collection {
      post :get_departments
    }
  end
  resources :privileges do
    collection {
      post  :get_customers_by_country
      post  :create_update
    }
  end
  get 'functionalities' => 'functionalities#index'
  resources :allergies
  resources :todos do
    collection {
      get :edit_search
      get :edit_index
      get :report_search
      get :report_index
      get :report_details
    }
  end
  resources :franchises
  resources :partners

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
