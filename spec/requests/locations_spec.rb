require 'spec_helper'

describe "Locations" do
  describe "GET /locations" do
    it "works!" do
      get locations_path
      response.status.should be(200)
    end
  end

  describe "overview" do
  	let(:location) { FactoryGirl.create(:location, :with_conditions) }
  	let(:conditions) { FactoryGirl.create(:conditions) }
  	before { visit location_path(location.id) }
  	subject {page}
  	it "shows the current Temperature" do
  		body.should have_content(conditions.temp)
  	end
  	it "shows the current Wind Speed" do
  		body.should have_content(conditions.wind_speed)
  	end
  	it "shows the current Wind Direction" do
  		body.should have_content(conditions.wind_direction)
  	end
  	it "has a link to history" do
  		body.should have_link("History", :href => location_history_path(location))
  	end
  end

  describe "list" do
    describe "shows all" do
      before do
        @location_count = 3
        FactoryGirl.create_list(:location, @location_count, :with_conditions)
        visit locations_path
      end

      it "locations" do
        page.body.should have_css(".location", :count => @location_count)
      end
      it "temperatures" do
        page.body.should have_css(".temp", :count => @location_count)
      end
      it "wind speeds" do
        page.body.should have_css(".wind-speed", :count => @location_count)
      end
      it "wind directions" do
        page.body.should have_css(".wind-direction", :count => @location_count)
      end
    end
  end
end
