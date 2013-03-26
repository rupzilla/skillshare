class HomeController < ApplicationController
  # include ApplicationHelper

  def index
    @user = current_user
	end


end