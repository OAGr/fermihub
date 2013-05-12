class Operation < ActiveRecord::Base
  attr_accessible :operator
  has_one :distribution
  has_and_belongs_to_many :inputs, :class_name => "Distribution"
end
