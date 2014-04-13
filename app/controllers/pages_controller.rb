class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:home, :api]

  def home
  end

  def api
  end

  def welcome
  	render layout: false
  end
end
