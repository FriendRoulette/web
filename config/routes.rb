Rails.application.routes.draw do	
	namespace :api, path: '/', constraints: { subdomain: 'api' }, 
 							   default: { format: 'json' } do
 		root to: '/pages#api'

 		resources :users do
 			member do
 				post :create
 				get :friends
 			end

 			collection do
  				get :find_token
  			end
 		end
 	end

	resources :users
	
 	devise_for :users, :skip => [:sessions]
 	as :user do
 		get "logout" => "devise/session#destroy"
 	end

	match '/auth/:provider/callback', to: 'authentications#create', via: [:get, :post]
	match 'auth/failure', to: redirect('/'), via: [:get, :post]

	match 'welcome', to: 'pages#welcome', as: 'welcome', via: [:get]

	root to: 'pages#home'
end
