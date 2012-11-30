require "spec_helper"

describe LocationsController do
  describe "routing" do

    it "routes to #index" do
      get("/locations").should route_to("locations#index")
    end

    it "routes to #new" do
      get("/locations/new").should route_to("locations#new")
    end

    it "routes to #show" do
      get("/locations/San_Francisco").should route_to("locations#show", :id => "San_Francisco")
    end

    it "routes to #history" do
      get("/locations/San_Francisco/history").should route_to("locations#history", :id => "San_Francisco")
    end

    it "routes to #edit" do
      get("/locations/San_Francisco/edit").should route_to("locations#edit", :id => "San_Francisco")
    end

    it "routes to #create" do
      post("/locations").should route_to("locations#create")
    end

    it "routes to #update" do
      put("/locations/San_Francisco").should route_to("locations#update", :id => "San_Francisco")
    end

    it "routes to #destroy" do
      delete("/locations/San_Francisco").should route_to("locations#destroy", :id => "San_Francisco")
    end

  end
end
