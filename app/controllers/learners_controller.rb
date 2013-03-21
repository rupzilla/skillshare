class LearnersController < ApplicationController
  # GET /learners
  # GET /learners.json
  def index
    @learners = Learner.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @learners }
    end
  end

  # GET /learners/1
  # GET /learners/1.json
  def show
    @learner = Learner.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @learner }
    end
  end

  # GET /learners/new
  # GET /learners/new.json
  def new
    @learner = Learner.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @learner }
    end
  end

  # GET /learners/1/edit
  def edit
    @learner = Learner.find(params[:id])
  end

  # POST /learners
  # POST /learners.json
  def create
    @learner = Learner.new(params[:learner])

    respond_to do |format|
      if @learner.save
        format.html { redirect_to @learner, notice: 'Learner was successfully created.' }
        format.json { render json: @learner, status: :created, location: @learner }
      else
        format.html { render action: "new" }
        format.json { render json: @learner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /learners/1
  # PUT /learners/1.json
  def update
    @learner = Learner.find(params[:id])

    respond_to do |format|
      if @learner.update_attributes(params[:learner])
        format.html { redirect_to @learner, notice: 'Learner was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @learner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /learners/1
  # DELETE /learners/1.json
  def destroy
    @learner = Learner.find(params[:id])
    @learner.destroy

    respond_to do |format|
      format.html { redirect_to learners_url }
      format.json { head :no_content }
    end
  end
end
