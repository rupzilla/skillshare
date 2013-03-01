class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create]

  def new
    @user = User.new
	unless params[:learner].nil?
		@user.learner_id = params[:learner]
	end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
	  UserMailer.new_user_msg(@user).deliver
#	  session[:user_id] = @user.id
      redirect_to home_path, :notice => "#{@user.learner.first_name} has been added as a user and notified by email."
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to home_path, :notice => "#{@user.learner.first_name}'s profile has been updated."
    else
      render :action => 'edit'
    end
  end
end
