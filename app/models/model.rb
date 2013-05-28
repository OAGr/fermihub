class Model < ActiveRecord::Base
  attr_accessible :name, :user_id
  has_and_belongs_to_many :distributions
  belongs_to :user

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
