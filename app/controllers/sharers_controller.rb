class SharersController < ApplicationController
  # GET /sharers
  # GET /sharers.json
  def index
    @sharers = Sharer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sharers }
    end
  end

  # GET /sharers/1
  # GET /sharers/1.json
  def show
    @sharer = Sharer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sharer }
    end
  end

  # GET /sharers/new
  # GET /sharers/new.json
  def new
     @sharer = Sharer.new
     @sharer.user_id ||= current_user.id
     @sharer.first_name ||= current_user.first_name
     @sharer.last_name ||= current_user.last_name
     #     
     #@sharer.user = User.find(current_user)   
  end

  # GET /sharers/1/edit
  def edit
    @sharer = Sharer.find(params[:id])
  end

  # POST /sharers
  # POST /sharers.json
  def create
    @sharer = Sharer.new(params[:sharer])

    respond_to do |format|
      if @sharer.save
        format.html { redirect_to @sharer, notice: 'Tutor was successfully created.' }
        format.json { render json: @sharer, status: :created, location: @sharer }
      else
        format.html { render action: "new" }
        format.json { render json: @sharer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sharers/1
  # PUT /sharers/1.json
  def update
    @sharer = Sharer.find(params[:id])

    respond_to do |format|
      if @sharer.update_attributes(params[:sharer])
        format.html { redirect_to @sharer, notice: 'Tutor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sharer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sharers/1
  # DELETE /sharers/1.json
  def destroy
    @sharer = Sharer.find(params[:id])
    @sharer.destroy

    respond_to do |format|
      format.html { redirect_to sharers_url }
      format.json { head :no_content }
    end
  end
end
