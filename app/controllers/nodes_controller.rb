require 'nodes'
class NodesController < ApplicationController
  def index
    @nodes = Node.all
    respond_to do |format|
      format.json { render json: @nodes }
    end
  end
end

