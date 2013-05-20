require 'edges'

class EdgesController < ApplicationController
  def index
    @edges = params[:model_id] ? Edge.all(params[:model_id]) : Edge.all
    respond_to do |format|
      format.json { render json: @edges }
    end
  end
end

