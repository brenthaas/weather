require 'spec helper'

describe Conditions do
	it { should respond_to :location }
	it { should respond_to :temp }
	it { should respond_to :wind_speed }
	it { should respond_to :wind_direction }
end