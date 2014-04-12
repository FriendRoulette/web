class UsersController < ApplicationController
    def index
      @user = User.all

      render json: @user
    end

    def show
      @user = User.find(params[:id])

#      render json: @user
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