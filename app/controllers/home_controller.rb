class HomeController < ApplicationController
  # include ApplicationHelper

  before_filter :check_login
  def index
    @user = current_user
	end


end