NamingApp::Application.routes.draw do
  #match '/message', to: 'message#index',        via: 'get'

  resources :messages, only: [:create, :destroy]
  resources :answers, only: [:create, :update]

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :orders, only: [:new, :create, :show, :index, :update_price, :update_box_status, :update]
  resources :characters, only: [:show, :index, :edit, :update]

  resources :histories, only: [:index, :csv_export]

  root to: 'static_pages#home'


  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/history', to: 'histories#index',       via: 'get'
  
  match '/history', to: 'histories#csv_export',       via: 'post'
  match '/search/orders', to: 'orders#index',     via: 'post'
  match '/search/characters', to: 'characters#index',     via: 'post'
  match '/price/:id', to: 'orders#update_price',     via: 'put'
  match '/orders/bs/:id', to: 'orders#update_box_status',     via: 'put'
  # The priority is based upon orders of creation: first created -> highest priority.
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
