require 'dis'
#encoding: utf-8
#!/bin/env ruby
# encoding: utf-8
class Distribution < ActiveRecord::Base
  SIGNIFICANT_DIGITS = 8
  has_and_belongs_to_many :outputs, :class_name => "Operation"
  has_and_belongs_to_many :models
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
    #!/bin/env ruby
# encoding: utf-8
    "#{round(mean)} +- #{round(spread)}"
  end
  "%.4g" % 1342254513

  def round(float)
   float.nil? ? "0" : "%.#{SIGNIFICANT_DIGITS}g" % float
  end
end
