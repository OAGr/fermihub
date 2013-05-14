require 'dis'
class Distribution < ActiveRecord::Base
  has_and_belongs_to_many :outputs, :class_name => "Operation"
  attr_accessible :name, :mean, :spread, :wideness
  before_save :default_values
  after_save :output_evaluate!

  def default_values
    self.spread ||= 0
  end

  def output_evaluate!
    outputs.each {|o| o.evaluate!}
  end

  def to_dis
    Dis.new(mean,spread,wideness)
  end
  def to_s
    name || to_num
  end
  def to_num
    "#{mean}+-#{spread}"
  end
end
