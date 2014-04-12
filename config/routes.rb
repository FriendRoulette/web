Rails.application.routes.draw do
	namespace :api, path: '/', constraints: { subdomain: 'api' }, 
 							   default: { format: 'json' } do
 		root to: '/pages#api'

 		resources :users do
 			member do
 				post :create
 			end
 		end
 	end

	match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
	match 'auth/failure', to: redirect('/'), via: [:get, :post]
	match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

	root to: 'pages#home'
end
