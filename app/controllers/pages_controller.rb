class PagesController < ApplicationController
  def home
    @model = Model.first
    @operations = @model.operations
    @distributions = @model.distributions
    @dependents = @model.dependents
    @independents = @model.independents
  end

  def operations

  end
end 
