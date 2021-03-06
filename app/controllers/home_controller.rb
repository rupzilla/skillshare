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
    if current_user.is_sharer?
      @workshops_for_sharer = current_user.sharer.workshop
    else
      nil
    end
	end

  def search
    @query = params[:query]
    @sharers = Sharer.search(@query)
    @workshops = Workshop.search(@query)
    @total_hits = @sharers.size + @workshops.size
  end

end