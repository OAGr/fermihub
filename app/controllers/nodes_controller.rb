require 'nodes'
class NodesController < ApplicationController
  def index
    @nodes = params[:model_id] ? Node.all(params[:model_id]) : Node.all
    #@nodes = Node.all(1)
    respond_to do |format|
      format.json { render json: @nodes }
    end
  end
end

