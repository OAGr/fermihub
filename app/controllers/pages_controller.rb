class PagesController < ApplicationController
  def home
    @operations = Operation.all
    @distributions = Distribution.all
    @dependents = Dependent.all
    @independents = Independent.all
  end
end 
