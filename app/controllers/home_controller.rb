class HomeController < ApplicationController
  # include ApplicationHelper

  before_filter :check_login
  def index
    @user = current_user
    @subscription = Subscription.all
    @workshops = Workshop.all
	end
	
	def dashboard
	  @user = current_user
    @subscription = current_user.subscriptions
    @workshops = current_user.workshops
    @workshops_for_sharer = current_user.sharer.workshop
    
	end

  

end