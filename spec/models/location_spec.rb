require 'spec_helper'

describe Location do
	let(:location) { FactoryGirl.create :location }
	subject { location }
  describe 'method calls' do
  	it { should respond_to :name }
  	it { should respond_to :current_conditions }
  	it { should respond_to :conditions }
  end

  describe 'validations' do
  	specify "doesn't accept no name" do 
  		invalid_location = Location.new()
  		invalid_location.should_not be_valid 
  	end
  	specify "doesn't accept blank names" do
  		invalid_location = Location.new(:name => "    ")
  		invalid_location.should_not be_valid 
  	end
  end

  describe 'current conditions' do
  	before { @conditions = FactoryGirl.create :conditions }
  	before { location.current_conditions = @conditions }

  	it 'appends the current conditions to history' do
  		location.save 
  		location.conditions.last.should == location.current_conditions
  	end
  end
end
