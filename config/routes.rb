Rails.application.routes.draw do

  ####### ROOT
  root 'index#index'
  
  ####### SUPER ADMIN
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
      get :titles_search
      resources :titles
    }
  end
  resources :franchises
  resources :partners

####### DAYCARE MANAGER
  namespace :manager do
    get  'login' => 'login#index'
    post 'login' => 'login#login'
    get  'logout'  => 'login#logout'
    get  'home' => 'home#index'

    resources :todos do
    collection {
      get :edit_index
      get :report_search
      get :report_index
      get :report_details
    }
    end
    resources :register
    resources :daycare
    get 'congratulate' => 'congratulate#index'
    get 'invite_workers' => 'congratulate#invite_workers'
    post 'invite_workers' => 'congratulate#invite_workers2'
    get 'invite_parents' => 'congratulate#invite_parents'
    post 'invite_parents' => 'congratulate#invite_parents2'

  end

####### API
  namespace :api do
    
    resources :users do
      collection {
        get :login
        post :update_customer_id
        post :update_department_id
      }
    end

    resources :customers do
      collection {
        get :get_departments
        post :create_departments
        post :send_email_to_worker
        post :send_email_to_parent
        post :create_user_type
        get :get_user_types
      }
    end

    resources :todos do
      collection {
        post :post_subtask_compliance
        get :get_subtask_compliance
        post :post_task_compliance
        get :get_task_compliance
        post :delegate_todo
        get :get_titles
        post :complete_todo
        post :delete_todo
        get :get_active_departments
        get :get_active_user_types
        post :update_todo
        get :report_details
      }
    end

    resources :privileges

  end

end
