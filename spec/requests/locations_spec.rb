require 'spec_helper'

describe "Locations" do
  describe "list" do
    before do
      @location_count = 3
      FactoryGirl.create_list(:location, @location_count, :with_conditions)
      visit locations_path
    end

    subject {page.body}

    it "lists all locations" do
      should have_css(".current-conditions", :count => @location_count)
    end  

    describe "timestamp" do
      it "has a timestamp for the list" do
        should have_css("#location-list[data-time]")
      end
      it "uses the current time for the timestamp" do
        now = Time.now.to_i + 1
        find('#location-list')['data-time'].to_i.should == now
      end
    end
  end
end
