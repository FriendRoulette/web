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
    if(params[:clear])
      $redis.flushDB
      $redis.set('matchmaking-users', [])
    end

  	ids = $redis.sort('matchmaking-users')
  	@users = []

  	ids.each do |id|
  		user = User.where(uid: id).first
      unless user.nil?  
  	   	@users << user
      end
  	end
  end
end
