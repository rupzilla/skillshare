class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create]

  def new
    @user = User.new
   
    @user.active ||= true
    
 
  # unless params[:employee].nil?
  #   @user.employee_id = params[:employee]
  # end
  end

  def create
    
    @user = User.new(params[:user])
    @user.active ||= true
    if @user.save
#	  UserMailer.new_user_msg(@user).deliver
	  session[:user_id] = @user.id
      redirect_to home_path, :notice => "#{@user.proper_name} has been added as a user."
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
	authorize! :manage, @user
  end

  def update
    @user = current_user
	authorize! :manage, @user
    if @user.update_attributes(params[:user])
      redirect_to home_path, :notice => "#{@user.proper_name}'s profile has been updated."
	  @user.save	
    else
      render :action => 'edit'
      @user.save
    end
  end
end
