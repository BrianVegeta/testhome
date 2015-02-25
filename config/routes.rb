Rails.application.routes.draw do
  devise_for :users, :controllers => { 
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: "users/confirmations",
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  # devise_for :new_admins, :controllers => { 
  #   sessions: 'new_admins/sessions' 
  # }
  # devise_for :new_users, :controllers => { 
  #   :omniauth_callbacks => "new_users/omniauth_callbacks",
  #   sessions: 'new_users/sessions'
  # }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'home#index'

  get 'test', to: 'home#test', as: :test

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  get 'transfer_social_login/:provider', to: 'social/transfer_social_login#do_transfer', as: :transfer_social_login
  get 'ng_view/:template', to: 'ng_view#get', as: :ng_view

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


  namespace :sites do
    get ':organization_id', to: "index#index", as: :root
    # devise_for :users, path: ':organization_id/users', skip: :omniauth_callbacks, :controllers => { 
    #   sessions: 'sites/users/sessions',
    #   registrations: 'sites/users/registrations',
    #   passwords: 'sites/users/passwords',
    #   confirmations: "sites/users/confirmations"
    # }

    namespace :admin do
      get ':organization_id', to: "index#index", as: :root

      resources :styles, path: ':organization_id/styles'
      resources :auths, path: ':organization_id/auths'
      resources :organsubs, path: ':organization_id/organsubs'

      resources :organization_post_lists, path: ':organization_id/post_list' do
        resources :organization_posts, path: 'post'
      end
    end
  end

  namespace :admin do
    root "index#index"

    get 'organizations/search/:query', to:'organizations#search', as: :organizations_search
    resources :organizations do
      get 'trans_level/:trans_id', to: 'organizations#trans_level'
    end

    resources :styles
    resources :images
    resources :users, except: [:new, :create, :edit]
  end
end
