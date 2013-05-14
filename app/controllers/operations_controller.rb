class OperationsController < ApplicationController
  # GET /operations
  # GET /operations.json
  def index
    @operations = Operation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @operations }
    end
  end

  # GET /operations/1
  # GET /operations/1.json
  def show
    @operation = Operation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @operation }
    end
  end

  # GET /operations/new
  # GET /operations/new.json
  def new
    @operation = Operation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @operation }
    end
  end

  # GET /operations/1/edit
  def edit
    @operation = Operation.find(params[:id])
  end

  # POST /operations
  # POST /operations.json
  def create
    params[:operation]["inputs"] = filter_distribution_ids(params[:operation]["inputs"])
    @operation = Operation.new(params[:operation])
    respond_to do |format|
      if @operation.save
        format.html { redirect_to root_path, notice: 'Operation was successfully created.' }
        format.json { render json: @operation, status: :created, location: @operation }
      else
        format.html { render action: "new" }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /operations/1
  # PUT /operations/1.json
  def update
    @operation = Operation.find(params[:id])
    params[:operation]["inputs"] = filter_distribution_ids(params[:operation]["inputs"])
    respond_to do |format|
      if @operation.update_attributes(params[:operation])
        format.html { redirect_to root_path, notice: 'Operation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operations/1
  # DELETE /operations/1.json
  def destroy
    @operation = Operation.find(params[:id])
    @operation.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  def evaluate
    @operation = Operation.find(params[:id])
    @operation.evaluate!
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  def filter_distribution_ids(ids)
    ids.reject!{|c| c.empty?}.map{|a| Distribution.find(a)}
  end
end
