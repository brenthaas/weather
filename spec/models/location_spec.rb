require 'spec_helper'

describe Location do
  describe 'methods' do
  	it { should respond_to :name }
  	it { should respond_to :current_weather }
  	it { should respond_to :past_conditions }
  end
end
