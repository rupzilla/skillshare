class WorkshopsController < ApplicationController
  # GET /workshops
  # GET /workshops.json
  before_filter :check_login

  def index
    @workshops = Workshop.by_upvotes_size

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @workshops }
    end
  end

  # GET /workshops/1
  # GET /workshops/1.json
  def show
    @workshop = Workshop.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @workshop }
    end
  end

  # GET /workshops/new
  # GET /workshops/new.json
  def new
    @workshop = Workshop.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @workshop }
    end
  end

  # GET /workshops/1/edit
  def edit
    @workshop = Workshop.find(params[:id])
	authorize! :manage, @workshop
  end
  

  # POST /workshops
  # POST /workshops.json
  def create
    @workshop = Workshop.new(params[:workshop])
    @workshop.sharer_id = current_user.sharer.id
    respond_to do |format|
      if @workshop.save
        format.html { redirect_to @workshop, notice: 'Workshop was successfully created.' }
        format.json { render json: @workshop, status: :created, location: @workshop }
      else
        format.html { render action: "new" }
        format.json { render json: @workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /workshops/1
  # PUT /workshops/1.json
  def update
    @workshop = Workshop.find(params[:id])
	authorize! :manage, @workshop

    respond_to do |format|
      if @workshop.update_attributes(params[:workshop])
        format.html { redirect_to @workshop, notice: 'Workshop was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workshops/1
  # DELETE /workshops/1.json
  def destroy
    @workshop = Workshop.find(params[:id])
	authorize! :manage, @workshop
    @workshop.destroy
    flash[:notice] = "Successfully removed workshop from the AMC system."
    redirect_to workshops_url
    
    # @subscription = Subscription.find(params[:id])
    # @subscription.destroy
    # flash[:notice] = "Successfully unsubcribed from workshop."
    # redirect_to workshops_url
    
    # @upvote = Upvote.find(params[:id])
    # @upvote.destroy
    # flash[:notice] = "Successfully took away your vote from workshop."
    # redirect_to workshops_url
    
   
  end
end
