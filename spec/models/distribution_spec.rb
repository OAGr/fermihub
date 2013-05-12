require 'spec_helper'

describe Dependent do

  before do
    @dependent = Dependent.new(name:"test dependent item", mean:20, spread:10)
    @operation = @dependent.operation
  end

  subject { @dependent }

  it 'should create a operation' do
    dependent = Dependent.new
    expect {dependent.save!}.to change {Operation.count}.by(1)
  end

  it { should respond_to(:check_operation) }
  

end
