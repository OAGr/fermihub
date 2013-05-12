class Operation < ActiveRecord::Base
  attr_accessible :operator
  has_one :dependent, :class_name => "Dependent", :foreign_key => "operation_id"
  has_and_belongs_to_many :inputs, :class_name => "Distribution"

  def check_dependent
    unless dependent
      a = Dependent.new
      a.operation = self
      a.save
    end
  end

  def evaluate
    value = result
    dependent.from_dis(value)
  end

  def result
    case operator
    when "*"
      multiply
    when "+"
      add
    when nil
      raise 'nil operator'
    else
      raise 'invalid operator'
    end
  end

  def multiply
    dis = inputs.map{|input| input.to_dis}
    Dis.*(*dis)
  end
  def add
    dis = inputs.map{|input| input.to_dis}
    Dis.+(*dis)
  end
end
