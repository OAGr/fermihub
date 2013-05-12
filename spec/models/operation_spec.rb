require 'spec_helper'

describe Operation do

  before do
    @operation = Operation.create(operator: "*")
    @dependent = Dependent.find_by_operation_id(@operation.id)
    @inputs = [[40,5],[23,5],[12,2]].map{|a,b| Distribution.new(mean:a,spread:b)}
  end

  subject { @operation }

  it { should respond_to(:operator) }
  it { should be_valid }
  
  its(:operator) {should == "*"} 

  it 'should create a dependent' do
    operation = Operation.new
    expect {operation.save!}.to change {Distribution.count}.by(1)
  end

  it 'should be able to call operation' do
    @operation.dependent.should == @dependent
  end


end
