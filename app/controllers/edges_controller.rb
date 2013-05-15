require 'edges'

class EdgesController < ApplicationController
  def index
    @edges = Edge.all
    respond_to do |format|
      format.json { render json: @edges }
    end
  end
end

