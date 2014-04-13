class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:home, :api, :queue]

  def home
  end

  def api
  end

  def welcome
  	render layout: false
  end

  def queue
  	ids = $redis.sort('matchmaking-users')
  	@users = []

  	ids.each do |id|
  		user = User.where(uid: id).first
  		@users << user
  	end
  end
end
