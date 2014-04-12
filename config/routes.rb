Rails.application.routes.draw do
 	root to: 'pages#home'

 	namespace :api, path: '/', constraints: { subdomain: 'api' }, default: { format: 'json' } do
 		resources :users do
 			member do
 				post :create
 			end
 		end
 	end

	match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
	match 'auth/failure', to: redirect('/'), via: [:get, :post]
	match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
end
