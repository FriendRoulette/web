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

				if @user.save
					render json: @user
				else
					render json: { status: false }
				end
			end

			def create_oauth
				auth = params['token']

				puts '###YOLO#### ' + auth

				existing = User.find_by_token(auth)

				if !existing.nil?
					puts '###YOLO#### Exists'
					render json: existing
				else
					puts 'Does Not Exist'
					
					graph = Koala::Facebook::API.new(token)
					profile = graph.get_object("me")

				    id = profile["id"]
				    name = profile["name"]
				    email = profile["email"]

				    user = User.new(uid: id, name: name, email: email, oauth_token: auth)

				    if user.save
				    	puts '###YOLO#### Saved'
				    	render json: user
				    else
				    	puts '###YOLO#### Cannot Save'
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