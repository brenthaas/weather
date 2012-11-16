require 'spec_helper'

describe "GET location/:id/history" do
	let(:location) { FactoryGirl.create(:location, :with_conditions) }
	before { visit location_history_path(location.id) }

	describe "conditions list" do
		it "lists all weather conditions" do
			page.should have_css("tr.conditions", :count => location.conditions.length)
		end
	end
end