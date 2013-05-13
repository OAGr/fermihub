class PagesController < ApplicationController
  def home
    @operations = Operation.all
    @distributions = Distribution.all
  end
end 
