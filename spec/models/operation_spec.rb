require 'spec_helper'

describe Operation do

  before do
    @operation = Operation.create(operator: "*")
    @inputs = [[40,5],[23,5],[12,2]].map{|a,b| Distribution.new(mean:a,spread:b)}
    @product = 40*23*12
    @sum = 40+23+12
    @operation.inputs = @inputs
    @dependent = Dependent.find_by_operation_id(@operation.id)
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

  it 'should add correctly' do
    @operation.add.mean.should == @sum
  end

  it 'should multiply correctly' do
    @operation.multiply.mean.should == @product
  end

  it 'should perform the correct operator' do
    @operation.update_attributes(operator:'*')
    @operation.result.mean.should == @product
    @operation.update_attributes(operator:'+')
    @operation.result.mean.should == @sum
  end

  context 'should produce correct dis on evaluate' do
    subject {@operation.evaluate}
      its(:mean) {should == @product}
  end


end
