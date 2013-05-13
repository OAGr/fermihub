class Operation < ActiveRecord::Base
  attr_accessible :operator
  has_one :dependent, :class_name => "Dependent", :foreign_key => "operation_id", :dependent => :destroy
  has_and_belongs_to_many :inputs, :class_name => "Distribution"
  before_create :create_dependent

  def evaluate!
    value = result
    dependent.from_dis(value)
    return dependent
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
    puts "inputs"
    unless inputs.nil?
      inputs.map{|input| puts input.to_num}
    end
    puts "operator: #{operator}"
    binding.pry
    puts "Output: #{self.dependent.to_num}"
  end
  def equation
    input_eq = inputs.map{|input| input.to_num}.join(' * ')
    output_eq = "(#{input_eq}) = #{dependent.to_num}"
  end
end
