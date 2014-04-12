class PagesController < ApplicationController
  def home
  end

  def api
  	redirect_to 'http://github.com/pageandrew/lahacks-web'
  end
end
