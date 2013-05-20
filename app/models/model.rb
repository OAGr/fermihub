class Model < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :distributions

  def independents
    distributions.where("type = ?", "Independent")
  end

  def dependents
    distributions.where("type = ?", "Dependent")
  end
  def operations
    dependents.map{|d| d.operation}.compact
  end
end
