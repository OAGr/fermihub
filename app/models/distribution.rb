class Distribution < ActiveRecord::Base
  attr_accessible :spread, :mean, :wideness
  has_and_belongs_to_many :outputs, :class_name => "Operation"
  belongs_to :operation
end
