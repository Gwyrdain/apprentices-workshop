Rails.application.routes.draw do

  resources :areas do
    collection { post :import }
    resources :shares
    resources :helps
    resources :rooms do
      collection do
        get :edit_multiple
        put :edit_multiple
        post :edit_multiple
      end
      resources :rxdescs
      resources :exits do
        resources :triggers
      end
      resources :room_specials
    end
    resources :objs do
      collection do
        get :edit_multiple
        put :edit_multiple
        post :edit_multiple
      end
      resources :oxdescs
      resources :applies
    end
    resources :mobiles do
      collection do
        get :edit_multiple
        put :edit_multiple
        post :edit_multiple
      end
      resources :specials
      resources :shops
    end
    resources :specials
    resources :shops
    resources :room_specials
    resources :triggers
    resources :area_strings
    resources :resets do
      resources :sub_resets
    end
  end

  devise_for :users#, :controllers => { registrations: 'registrations' }
  root 'home#index'
  get 'home/about'
  
  get 'home/users'

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
