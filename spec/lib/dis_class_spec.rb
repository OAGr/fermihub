require 'spec_helper'
require 'Dis'

describe Dis do

  before do
    @dis1 = Dis.new(10,4)
    @dis2 = Dis.new(20,5)
    @dis3 = Dis.new(30,5)
    @dis4 = Dis.new(40,5)
  end

  context 'the make_dis function' do
    it 'should convert integers' do
      Dis.make_dis(1).class.should == Dis
    end
    it 'should convert floats' do 
      Dis.make_dis(1.0).class.should == Dis
    end
    it 'should do nothing for Dis' do
      Dis.make_dis(@dis1).should == @dis1
    end
    it 'should work well for multiple inputs' do
      Dis.make_dis(@dis1, 2, 4, 3.4)[0] == @dis1
    end
  end

  context 'the multiply function' do
    context 'with 3 dis' do
      subject {Dis.*(@dis1,@dis2,@dis3)}
      its(:class) {should == Dis}
      its(:mean) {should == 6000}
    end
    context 'with 2 dis' do
      subject {Dis.*(@dis1,@dis2)}
      its(:class) {should == Dis}
      its(:mean) {should == 200}
    end
    context 'with 1 dis, 1 int' do
      subject {Dis.*(@dis1,4)}
      its(:class) {should == Dis}
      its(:mean) {should == (@dis1.mean * 4)}
    end
  end

  context 'the add function' do
    context 'with 3 dis' do
      subject {Dis.+(@dis1,@dis2,@dis3)}
      its(:class) {should == Dis}
      its(:mean) {should == 60}
    end
    context 'with 2 dis' do
      subject {Dis.+(@dis1,@dis2)}
      its(:class) {should == Dis}
      its(:mean) {should == 30}
    end
    context 'with 1 dis, 1 int' do
      subject {Dis.+(@dis1,4)}
      its(:class) {should == Dis}
      its(:mean) {should == (@dis1.mean + 4)}
    end
  end
end
