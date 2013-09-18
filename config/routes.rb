Mlb::Application.routes.draw do
  get 'game/test', to: 'game#test'
  resource :favorites
  resources :batter_favorites
  resources :pitcher_favorites
  resources :team_favorites
  get "users/show"
  get "users/index"
  get "/auth/:provider/callback" => "sessions#create"
  get "/signout" => "sessions#destroy"
  get "sessions/create"
  get "sessions/destroy"
  resources :examples
  resources :favorites
  root to: 'team#index'
  get 'batter/leaders', to: 'batters#leaders'
  get 'batter/leaders/al', to: 'batters#al_leaders'
  get 'batter/leaders/nl', to: 'batters#nl_leaders'
  get 'batter/all', to: 'batters#all'
  get 'batter/al', to: 'batters#al'
  get 'batter/nl', to: 'batters#nl'
  get 'batter/:p_id' => 'batters#show'
  get 'batter/:p_id/split' => 'batters#split'
  get 'batter/:p_id/vs_pitcher' => 'batters#vs_pitcher'
  get 'batter/:p_id/highlight' => 'batters#highlight'
  get 'pitcher/leaders', to: 'pitchers#leaders'
  get 'pitcher/leaders/al', to: 'pitchers#al_leaders'
  get 'pitcher/leaders/nl', to: 'pitchers#nl_leaders'
  get 'pitcher/all', to: 'pitchers#all'
  get 'pitcher/al', to: 'pitchers#al'
  get 'pitcher/nl', to: 'pitchers#nl'
  get 'pitcher/:p_id' => 'pitchers#show'
  get 'pitcher/:p_id/split' => 'pitchers#split'
  get 'pitcher/:p_id/vs_batter' => 'pitchers#vs_batter'
  get 'pitcher/:p_id/highlight' => 'pitchers#highlight'
  get 'team/:team_id' => 'team#show'
  get 'team' => 'team#index'
  get 'all_team_hitting', to: 'team#all_hitting'
  get 'all_team_pitching', to: 'team#all_pitching'
  get 'al_team_hitting', to: 'team#al_hitting'
  get 'al_team_pitching', to: 'team#al_pitching'
  get 'nl_team_hitting', to: 'team#nl_hitting'
  get 'nl_team_pitching', to: 'team#nl_pitching'
  resources :team
  resources :media
  get 'game/show', to: 'game#show'
  get 'game/index', to: 'game#index'
  get 'game/atbat', to: 'game#atbat'
  get 'game/today', to: 'game#today_index'
  get 'game/today/:g_id', to: 'game#today_show'
  get 'game/highlight', to: 'game#highlight'
  resources :master_scoreboard
  post 'game_detail' => 'game_detail#game_details'
  resources :game_detail
  get 'pitchers', to: 'pitchers#index'
  get 'pitchings', to: 'pitch_type_details#pitchings'
  get 'battings', to: 'pitch_type_details#battings'

  # get 'master_scoreboard' => 'master_scoreboard#index'
  # get 'master_scoreboard/show' => 'master_scoreboard#show'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root to: 'welcome#index'

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

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
