# == Route Map
#
#                            Prefix Verb   URI Pattern                                                                      Controller#Action
#              api_v1_user_comments GET    /api/v1/users/:user_id/comments(.:format)                                        api/v1/comments#index
# api_v1_user_user_photo_collection GET    /api/v1/users/:user_id/photo_collection(.:format)                                api/v1/photos#show_collection
#                      api_v1_users GET    /api/v1/users(.:format)                                                          api/v1/users#index
#                       api_v1_user GET    /api/v1/users/:id(.:format)                                                      api/v1/users#show
#             api_v1_photo_comments GET    /api/v1/photos/:photo_id/comments(.:format)                                      api/v1/comments#index
#                     api_v1_photos GET    /api/v1/photos(.:format)                                                         api/v1/photos#index
#                      api_v1_photo GET    /api/v1/photos/:id(.:format)                                                     api/v1/photos#show
#                api_v1_user_search GET    /api/v1/users/:sub_name/search(.:format)                                         api/v1/users#search
#                        admin_root GET    /admin(.:format)                                                                 admin/dashboard#index
#                   admin_dashboard GET    /admin/dashboard(.:format)                                                       admin/dashboard#index
#               approve_admin_photo GET    /admin/photos/:id/approve(.:format)                                              admin/photos#approve
#                   ban_admin_photo GET    /admin/photos/:id/ban(.:format)                                                  admin/photos#ban
#         batch_action_admin_photos POST   /admin/photos/batch_action(.:format)                                             admin/photos#batch_action
#                      admin_photos GET    /admin/photos(.:format)                                                          admin/photos#index
#                                   POST   /admin/photos(.:format)                                                          admin/photos#create
#                   new_admin_photo GET    /admin/photos/new(.:format)                                                      admin/photos#new
#                  edit_admin_photo GET    /admin/photos/:id/edit(.:format)                                                 admin/photos#edit
#                       admin_photo GET    /admin/photos/:id(.:format)                                                      admin/photos#show
#                                   PATCH  /admin/photos/:id(.:format)                                                      admin/photos#update
#                                   PUT    /admin/photos/:id(.:format)                                                      admin/photos#update
#                                   DELETE /admin/photos/:id(.:format)                                                      admin/photos#destroy
#                    admin_comments GET    /admin/comments(.:format)                                                        admin/comments#index
#                                   POST   /admin/comments(.:format)                                                        admin/comments#create
#                     admin_comment GET    /admin/comments/:id(.:format)                                                    admin/comments#show
#                              root GET    /                                                                                photos#index
#                                   GET    /auth/:provider/callback(.:format)                                               sessions#create
#                            logout DELETE /logout(.:format)                                                                sessions#destroy
#                       user_photos GET    /photos(.:format)                                                                photos#index
#                            photos POST   /photos(.:format)                                                                photos#create
#                  instagram_search GET    /instagram_search(.:format)                                                      photos#instagram_search
#     current_user_photo_collection GET    /users/:user_id/photo_collection(.:format)                                       photos#show_collection
#                             photo GET    /photo/:id(.:format)                                                             photos#show
#   new_user_photo_comment_comments GET    /user/:user_id/photo/:photo_id/comment/:parent_comment_id/comments/new(.:format) comments#new
#       user_photo_comment_comments POST   /user/:user_id/photo/:photo_id/comment/:parent_comment_id/comments(.:format)     comments#create_sub_comment
#               user_photo_comments GET    /users/:user_id/photos/:photo_id/comments(.:format)                              comments#index
#                                   POST   /users/:user_id/photos/:photo_id/comments(.:format)                              comments#create
#            new_user_photo_comment GET    /users/:user_id/photos/:photo_id/comments/new(.:format)                          comments#new
#           edit_user_photo_comment GET    /users/:user_id/photos/:photo_id/comments/:id/edit(.:format)                     comments#edit
#                user_photo_comment GET    /users/:user_id/photos/:photo_id/comments/:id(.:format)                          comments#show
#                                   PATCH  /users/:user_id/photos/:photo_id/comments/:id(.:format)                          comments#update
#                                   PUT    /users/:user_id/photos/:photo_id/comments/:id(.:format)                          comments#update
#                                   DELETE /users/:user_id/photos/:photo_id/comments/:id(.:format)                          comments#destroy
#                  user_photo_likes POST   /users/:user_id/photos/:photo_id/likes(.:format)                                 likes#create
#                    new_user_photo GET    /users/:user_id/photos/new(.:format)                                             photos#new
#                   edit_user_photo GET    /users/:user_id/photos/:id/edit(.:format)                                        photos#edit
#                        user_photo GET    /users/:user_id/photos/:id(.:format)                                             photos#show
#                                   PATCH  /users/:user_id/photos/:id(.:format)                                             photos#update
#                                   PUT    /users/:user_id/photos/:id(.:format)                                             photos#update
#                                   DELETE /users/:user_id/photos/:id(.:format)                                             photos#destroy
#                             users GET    /users(.:format)                                                                 users#index
#                                   POST   /users(.:format)                                                                 users#create
#                          new_user GET    /users/new(.:format)                                                             users#new
#                         edit_user GET    /users/:id/edit(.:format)                                                        users#edit
#                              user GET    /users/:id(.:format)                                                             users#show
#                                   PATCH  /users/:id(.:format)                                                             users#update
#                                   PUT    /users/:id(.:format)                                                             users#update
#                                   DELETE /users/:id(.:format)                                                             users#destroy
#

Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :users, only: [:index, :show] do
        get '/photos',   to: 'photos#index'
        get '/comments', to: 'comments#index'
      end
      resources :photos, only: [:index, :create, :show] do
        resources :comments, only: [:create, :index]
        resources :likes, only: :create
      end
    end
  end




  ActiveAdmin.routes(self)
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'photos#index'

  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'photos', to: 'photos#index', as: 'user_photos'
  post 'photos', to: 'photos#create'

  get 'instagram_search', to: 'photos#instagram_search'
  get '/users/:user_id/photo_collection', to: 'photos#show_collection', as: 'current_user_photo_collection'
  get 'photo/:id', to: 'photos#show', as: 'photo'
  get '/user/:user_id/photo/:photo_id/comment/:parent_comment_id/comments/new', to: 'comments#new', as: 'new_user_photo_comment_comments'
  post '/user/:user_id/photo/:photo_id/comment/:parent_comment_id/comments', to: 'comments#create_sub_comment', as: 'user_photo_comment_comments'

  
  resources :users do
    resources :photos, except: [:index, :create] do
      resources :comments 
      resources :likes, only: [:create]
    end
  end
  
  
  
  
  
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
