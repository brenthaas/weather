require 'spec_helper'

describe Location do
	before { @location = FactoryGirl.create :location }
	subject { @location }
  describe 'methods' do
  	it { should respond_to :name }
  	it { should respond_to :current_weather }
  	it { should respond_to :past_weather }
  end
end
