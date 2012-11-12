require 'spec_helper'

describe "Locations" do
  describe "GET /locations" do
    it "works!" do
      get locations_path
      response.status.should be(200)
    end
  end
end
