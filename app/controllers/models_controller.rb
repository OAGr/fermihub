class ModelsController < ApplicationController
  # GET /models
  # GET /models.json
  def index
    @models = Model.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @models }
    end
  end

  def show
    @model = Model.find(params[:id])
    @operations = @model.operations
    @independents = @model.independents
    @dependents = @model.dependents

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @model }
    end
  end

  # GET /models/new
  # GET /models/new.json
  def new
    @model = Model.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @model }
    end
  end

  # GET /models/1/edit
  def edit
    @model = Model.find(params[:id])
  end

  # POST /Models
  # POST /Models.json
  def create
    @model = Model.new(params[:model])
    respond_to do |format|
      if @model.save
        format.html { redirect_to model_path(@model), notice: 'model was successfully created.' }
        format.json { render json: @model, status: :created, location: @model }
      else
        format.html { render action: "new" }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /models/1
  # PUT /models/1.json
  def update
    @model = Model.find(params[:id])
    respond_to do |format|
      if @model.update_attributes(params[:model])
        format.html { redirect_to model_path(@model), notice: 'model was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /models/1
  # DELETE /models/1.json
  def destroy
    @model = Model.find(params[:id])
    @model.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  def destroy_connection
    @model = Model.find(params[:id])
    @operation = Operation.find(params[:operation])
    @model.outputs.destroy(@operation)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end
end
