class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:home, :api]

  def home
  end

  def api
  	redirect_to 'http://github.com/pageandrew/lahacks-web'
  end

  def welcome
  	render layout: false
  end
end
