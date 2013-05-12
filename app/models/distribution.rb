require 'Dis'
class Distribution < ActiveRecord::Base
  has_and_belongs_to_many :outputs, :class_name => "Operation"
  attr_accessible :name, :mean, :spread, :wideness
  def to_dis
    Dis.new(mean,spread,wideness)
  end
  def to_s
    name
  end
end
