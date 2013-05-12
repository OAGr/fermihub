require 'spec_helper'
require 'Dis'

describe Dis do

  before do
    @dis1 = Dis.new(10,4)
    @dis2 = Dis.new(20,5)
  end

  subject { @dis1 }

  its(:mean) {should == 10}
  its(:to_i) {should == 10}
  its(:to_f) {should == 10.0}
  its(:interval) {should == 4}
  it 'to_dis is the same' do
    @dis1.should == @dis1.to_dis
  end
  
  it "should add correctly" do
    addition = @dis1 + @dis2
    addition.mean.should == 30
  end

  it "makes be a dis when added" do
    addition = @dis1 + @dis2
    addition.class.should == Dis
  end

  it "does multiply correctly" do
    addition = @dis1 + @dis2
    addition.mean.should == 30
  end



end
