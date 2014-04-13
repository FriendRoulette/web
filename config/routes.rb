Rails.application.routes.draw do
	## PUBLIC ##	
 	constraints(:subdomain => /^(?!api)(\w+)/) do 
		resources :users
		
	 	devise_for :users
	 	as :user do
	 		delete "logout" => "devise/sessions#destroy"
	 	end

		match '/auth/:provider/callback', to: 'authentications#create', via: [:get, :post]
		match 'auth/failure', to: redirect('/'), via: [:get, :post]

		match 'welcome', to: 'pages#welcome', as: 'welcome', via: [:get]
	end

	## API ##
	namespace :api, path: '/', constraints: { subdomain: 'api' }, 
 							   default: { format: 'json' } do
 		get '/' => '/pages#api', as: 'api_root'

 		namespace :v1, path: '/' do
	 		resources :user do
	 			member do
	 				post :create
	 				get :friends
	 			end

	 			collection do
	  				get :find_token
					post :create_oauth
	  			end
	 		end
	 	end
 	end

	root to: 'pages#home'
end
