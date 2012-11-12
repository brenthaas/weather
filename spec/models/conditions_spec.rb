require 'spec_helper'

describe Conditions do
	before do 
		@weather = Conditions.create(:temp => 75.5, :wind_speed => 12, :wind_direction => "NW")
	end
	subject { @weather }
	it { should respond_to :location }
	it { should respond_to :temp }
	it { should respond_to :wind_speed }
	it { should respond_to :wind_direction }
	it { should be_valid }

	describe "validators" do
		it "does not accept negative wind speed" do
			@weather.wind_speed = -5
			should_not be_valid
		end

		context "don't accept weird wind directions" do
			specify "with invalid characters" do
				@weather.wind_direction = "dn"
				should_not be_valid
			end
			specify "long directions" do
				@weather.wind_direction = "swe"
				should_not be_valid
			end
		end
	end

	describe "normalizing" do
		it "upcases wind direction" do
			@weather.wind_direction = "sw"
			@weather.wind_direction.should == "SW"
		end
	end
end