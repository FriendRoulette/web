module Api
	module V1
		class UserController < ApplicationController
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
				friends = User.find(params[:id]).graph.get_connections("me", "friends")

				render json: friends
			end

			def create
				@user = User.new(user_params)

				if @user.save
					render json: @user
				else
					render json: { status: false }
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
				params.require(:user).permit(:name)
			end
		end
	end
end