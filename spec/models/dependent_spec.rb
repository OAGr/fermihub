require 'spec_helper'

describe Dependent do

  before(:each) do
    @operation = Operation.create
    @dependent = @operation.dependent
  end

  subject { @dependent }

  it 'should be able to call operation' do
    @dependent.operation.should == @operation
  end


end
