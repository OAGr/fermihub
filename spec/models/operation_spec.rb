require 'spec_helper'

describe Operation do

  before do
    @operation = Operation.new(operator: "*")
    @inputs = [[40,5],[23,5],[12,2]].map{|a,b| Distribution.new(a,b)}
  end

  subject { @operation }

  it { should respond_to(:operator) }
  it { should be_valid }
  
  its(:operator) {should == "*"} 

end
