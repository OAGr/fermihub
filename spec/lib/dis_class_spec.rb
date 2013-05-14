require 'spec_helper'
require 'dis'

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
      its(:mean) {should == (@dis1.mean * @dis2.mean * @dis3.mean)}
    end
    context 'with 2 dis' do
      subject {Dis.*(@dis1,@dis2)}
      its(:mean) {should == 200}

      total_error = 0.4 + 0.25
      true_interval = total_error * 200
      its(:interval) {should == true_interval}
    end
    context 'with 1 dis, 1 int' do
      subject {Dis.*(@dis1,4)}
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
      its(:mean) {should == 30}
    end
    context 'with 1 dis, 1 int' do
      subject {Dis.+(@dis1,4)}
      its(:mean) {should == (@dis1.mean + 4)}
    end
    context 'with 1 dis' do
      subject {Dis.+(@dis1)}
      its(:mean) {should == @dis1.mean}
      its(:interval) {should == @dis1.interval}
    end
  end

end
