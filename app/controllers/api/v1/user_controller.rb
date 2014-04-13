module Api
	module V1
		class UserController < ApplicationController
			skip_before_filter  :verify_authenticity_token
			
			def index
				@user = User.all

				render json: @user
			end

			def show
				@user = User.find(params[:id])

				render json: @user
			end

			def find_token
				token = params[:token]

				user = User.find_by_token(token)

				if !user.nil?
					render json: user
				else
					render json: { status: false }
				end
			end

			def friends
				user = User.find(params[:id])

				render json: user.friends
			end

			def create
				@user = User.new(user_params)
				p "IN USER CREATE"
				p @user
				p @user_params

				p "params"
				p params
				auth = params['oauth']
				p "auth"
				p auth
				existing = User.find_by_token(auth)
				p "existing"
				p existing

				#if @user.save
				if (1 == 2)
					p "USER IS BEing saved"
					render json: @user
				else
					#render json: { status: false }
					if !existing.nil?
						p "FIRST"
						render json: existing
					else
						p "ELSE"
						graph = Koala::Facebook::API.new(token)
						profile = graph.get_object("me")
					    id = profile["id"]
					    name = profile["name"]
					    email = profile["email"]
					    user = User.new(uid: id, name: name, email: email, oauth_token: auth)
					    if user.save
					    	render json: user
					    else
					    	render json: user.errors.full_messages
					    end
					end
				end
			end

			def create_oauth
				p "Create Oauth"
				auth = params['oauth']
				p "auth"
				p auth
				existing = User.find_by_token(auth)
				p "existing"
				p existing
				if !existing.nil?
					render json: existing
				else
					
					graph = Koala::Facebook::API.new(token)
					profile = graph.get_object("me")

				    id = profile["id"]
				    name = profile["name"]
				    email = profile["email"]

				    user = User.new(uid: id, name: name, email: email, oauth_token: auth)

				    if user.save
				    	render json: user
				    else
				    	render json: user.errors.full_messages
				    end
				end
			end

			def update
				@user = User.find(params[:id])

				@user.update_attributes(user_params)

				render json: { status: true }
			end

			def destroy
				@user = User.find(params[:id])

				@user.destroy

				render json: { status: true }
			end

			private
			def user_params
				params.permit(:name, :uid, :email, :oauth_token, :provider)
			end
		end
	end
end