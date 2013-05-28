class OperationsController < ApplicationController
  # GET /operations
  # GET /operations.json
  def index
    @operations = Operation.all
    @model = Model.find(params[:model_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @operations }
    end
  end

  # GET /operations/1
  # GET /operations/1.json
  def show
    @operation = Operation.find(params[:id])
    @model = Model.find(params[:model_id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @operation }
    end
  end

  # GET /operations/new
  # GET /operations/new.json
  def new
    @user = current_user
    @model = Model.find(params[:model_id])
    @operation = Operation.new
    @distributions = @model.distributions

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @operation }
    end
  end

  # GET /operations/1/edit
  def edit
    @operation = Operation.find(params[:id])
    @model = Model.find(params[:model_id])
    @user = @model.user
    @distributions = @model.distributions - [@operation.dependent]
  end

  # POST /operations
  # POST /operations.json
  def create
    params[:operation]["inputs"] = filter_distribution_ids(params[:operation]["inputs"])
    @operation = Operation.new(params[:operation])
    @model = Model.find(params[:model_id])
    respond_to do |format|
      if @operation.save
        if @model
          @operation.dependent.models << @model
          format.html { redirect_to user_model_path(@model.user, @model), notice: 'Operation was successfully created.' }
        else
          format.html { redirect_to root_path, notice: 'Operation was successfully created.' }
        end 
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
    @model = Model.find(params[:model_id])
    respond_to do |format|
      if @operation.update_attributes(params[:operation])
        format.html { redirect_to user_model_path(@model.user,@model), notice: 'Operation was successfully updated.' }
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
    @model = Model.find(params[:model_id])
    @operation.destroy

    respond_to do |format|
      format.html { redirect_to user_model_path(@model.user, @model) }
      format.json { head :no_content }
    end
  end

  def evaluate
    @operation = Operation.find(params[:id])
    @operation.evaluate!
    @model = Model.find(params[:model_id])
    respond_to do |format|
      format.html { redirect_to user_model_path(@model.user, @model) }
      format.json { head :no_content }
    end
  end

  def filter_distribution_ids(ids)
    ids.reject!{|c| c.empty?}.map{|a| Distribution.find(a)}
  end
end
