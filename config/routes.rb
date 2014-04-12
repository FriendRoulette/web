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

 	devise_for :users

	match '/auth/:provider/callback', to: 'authentications#create', as: 'login', via: [:get, :post]
	match 'auth/failure', to: redirect('/'), via: [:get, :post]

	match 'welcome', to: 'pages#welcome', as: 'welcome', via: [:get]
	match 'logout', to: 'sessions#destroy', as: 'logout', via: [:get, :post]

	root to: 'pages#home'
  	match '/',        to: 'pages#home', as: 'home', via: [:get]
end
