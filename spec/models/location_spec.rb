require 'spec_helper'

describe Location do
	before { @location = FactoryGirl.create :location }
	subject { @location }
  describe 'method calls' do
  	it { should respond_to :name }
  	it { should respond_to :current_conditions }
  	it { should respond_to :conditions_history }
  end

  describe 'current conditions' do
  	before { @conditions = FactoryGirl.create :conditions }
  	before { @location.current_conditions = @conditions }

  	it 'appends the current conditions to history' do
  		@location.save 
  		@location.conditions_history.last.should == @location.current_conditions
  	end
  end
end
