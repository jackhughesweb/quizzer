Quizzer::Application.routes.draw do

  
  devise_for :users
  resources :quizzes do 
    resources :categories do
      resources :questions do
        collection { post :sort }
      end
      collection { post :sort }
    end
    collection { post :sort }
  end

  resources :games

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#index'

  get 'g/:link_url' => 'games#playgame', as: :playgame
  get 'g/:link_url/update' => 'games#gameupdate', as: :gameupdate

  get 'g/:link_url/player/new' => 'players#new', as: :newplayer
  get 'g/:link_url/player/signup' => 'players#signup', as: :newplayersignup
  post 'g/:link_url/player/create' => 'players#create', as: :newplayercreate
  get 'g/:link_url/player/login' => 'players#login', as: :newplayerlogin
  post 'g/:link_url/player/login' => 'players#join', as: :newplayerjoin
  get 'g/:link_url/player/logout' => 'players#logout', as: :newplayerlogout
  get 'glogout' => 'players#logoutf', as: :forcelogout

  get 'g/:link_url/dashboard' => 'games#dashboard', as: :gamedashboard
  get 'g/:link_url/start' => 'games#start', as: :gamestart
  get 'g/:link_url/next' => 'games#nextquestion', as: :gamenextquestion
  get 'g/:link_url/results' => 'games#results', as: :gameresults

  post 'g/:link_url/questions/answer' => 'answers#new', as: :gameanswer

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
