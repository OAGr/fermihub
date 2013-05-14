class Operation < ActiveRecord::Base
  attr_accessible :operator, :inputs
  has_one :dependent, :class_name => "Dependent", :foreign_key => "operation_id", :dependent => :destroy
  has_and_belongs_to_many :inputs, :class_name => "Distribution"
  before_create :create_dependent
  before_save :evaluate!

  def evaluate!
    unless inputs.empty?
    value = result
    dependent.from_dis(value)
    dependent
    end
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

  def list
    string = ""
    string << "Inputs \n"
    unless inputs.nil?
      string << inputs.map{|input| "#{input.to_num}"}.join("\n")
    end
    string << "\nOperator: #{operator} \n"
    string << "Output: \n#{self.dependent.to_num}"
    return string
  end
  def equation
    input_eq = inputs.map{|input| input.to_num}.join(" #{operator} ")
    output_eq = "(#{input_eq}) = #{dependent.to_num}"
  end
end
