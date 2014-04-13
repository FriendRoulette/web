class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @friends = User.find(params[:id]).graph.get_connections("me", "friends")
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params[:user]
    end
end
