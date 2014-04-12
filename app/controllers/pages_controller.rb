class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
  end

  def api
  	redirect_to 'http://github.com/pageandrew/lahacks-web'
  end

  def welcome
  	render layout: false
  end
end
