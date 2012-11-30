require 'spec_helper'

describe '/location/:id' do
  let(:location) { FactoryGirl.create(:location, :with_conditions) }
  let(:conditions) { FactoryGirl.create(:conditions) }
  before { visit location_path(location) }
  subject {page.body}

  describe "displayed info" do
    it "shows the location name" do
      should have_content(location.name)
    end
  	it "shows the current Temperature" do
  		should have_content(conditions.temp)
  	end
  	it "shows the current Wind Speed" do
  		should have_content(conditions.wind_speed)
  	end
  	it "shows the current Wind Direction" do
  		should have_content(conditions.wind_direction)
  	end
  	it "has a link to history" do
  		should have_link("History", :href => history_location_path(location))
  	end
  end
end