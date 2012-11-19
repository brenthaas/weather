require 'spec_helper'

describe ConditionsController do
	before do
		@conditions_list = FactoryGirl.create_list(:conditions, 10).sort_by{|t| t.created_at}
	end
	describe "GET index" do
		it "gets all conditions by default" do
			get :index, :format => 'json'
			assigns(:conditions).should eq @conditions_list
		end

		it "gets only conditions newer than time specified" do
			after_index = 3 
			get :index, {:since => @conditions_list[after_index].timestamp+1}
			assigns(:conditions).should eq @conditions_list[(after_index+1)..@conditions_list.length]
		end
	end
end