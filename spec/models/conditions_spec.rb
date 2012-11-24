require 'spec_helper'

describe Conditions do
	let(:weather) {
		Conditions.create(temp: 75.5, wind_speed: 12, wind_direction: "NW")
	}
	subject { weather }
	it { should respond_to :location }
	it { should respond_to :temp }
	it { should respond_to :wind_speed }
	it { should respond_to :wind_direction }
	it { should be_valid }

	describe "validators" do
		it "does not accept negative wind speed" do
			weather.wind_speed = -5
			should_not be_valid
		end

		context "don't accept weird wind directions" do
			specify "with invalid characters" do
				weather.wind_direction = "dn"
				should_not be_valid
			end
			specify "long directions" do
				weather.wind_direction = "swe"
				should_not be_valid
			end
		end
	end

	describe "#wind_direction" do
		it "upcases wind direction" do
			weather.wind_direction = "sw"
			weather.wind_direction.should == "SW"
		end
	end

	describe "#updated_since" do
		context "all time" do
			it "gives all conditions" do
				Conditions.updated_since(0).should == Conditions.all
			end
		end
		context "now" do
			it "gives no conditions" do
				Conditions.updated_since(Time.now.to_i+5).should be_empty
			end
		end
	end
end