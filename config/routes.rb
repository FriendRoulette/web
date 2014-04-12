Rails.application.routes.draw do
 	root to: 'pages#home'

 	namespace :api, path: '/', constraints: { subdomain: 'api' } do
 		
 	end

	match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
	match 'auth/failure', to: redirect('/'), via: [:get, :post]
	match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
end
