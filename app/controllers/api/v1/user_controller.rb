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

			def oauth_create
				auth = params['oauth']

				existing = User.find_by_token(auth)

				if !existing.nil?
					render json: existing
				else
					
					graph = Koala::Facebook::API.new(auth)
					profile = graph.get_object("me")

				    id = profile["id"]
				    name = profile["name"]
				    email = profile["email"]

				    user = User.new(uid: id, name: name, email: email, oauth_token: auth, password: 'asskon123asskon123')

				    if user.save
				    	user.firebase.set('uuid', '')

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