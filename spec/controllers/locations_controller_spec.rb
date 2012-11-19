require 'spec_helper'

describe LocationsController do

  # This should return the minimal set of attributes required to create a valid
  # Location. As you add validations to Location, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { :name => "Valid Location Name" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LocationsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all locations as @locations in order" do
      location = Location.create! valid_attributes
      get :index, {}, valid_session
      assigns(:locations).should eq([location])
    end
    it "gives all locations in alphabetical order" do
      second = FactoryGirl.create(:location, :name => "New York") 
      third = FactoryGirl.create(:location, :name => "Zurich") 
      first = FactoryGirl.create(:location, :name => "Boston") 
      get :index, {}, valid_session
      assigns(:locations).should eq([first, second, third])
    end
  end

  describe "GET show" do
    it "assigns the requested location as @location" do
      location = Location.create! valid_attributes
      get :show, {:id => location.to_param}, valid_session
      assigns(:location).should eq(location)
    end
  end

  describe "GET history" do
    it "assigns the recent conditions to @conditions_list" do
      location = FactoryGirl.create(:location, :with_conditions)
      conditions = location.conditions
      get :history, {:id => location.to_param, :after => 0}, valid_session
      assigns(:conditions_list).should eq(conditions)
    end
  end

  describe "GET new" do
    it "assigns a new location as @location" do
      get :new, {}, valid_session
      assigns(:location).should be_a_new(Location)
    end
  end

  describe "GET edit" do
    it "assigns the requested location as @location" do
      location = Location.create! valid_attributes
      get :edit, {:id => location.to_param}, valid_session
      assigns(:location).should eq(location)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Location" do
        expect {
          post :create, {:location => valid_attributes}, valid_session
        }.to change(Location, :count).by(1)
      end

      it "assigns a newly created location as @location" do
        post :create, {:location => valid_attributes}, valid_session
        assigns(:location).should be_a(Location)
        assigns(:location).should be_persisted
      end

      it "redirects to the created location" do
        post :create, {:location => valid_attributes}, valid_session
        response.should redirect_to(locations_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved location as @location" do
        # Trigger the behavior that occurs when invalid params are submitted
        Location.any_instance.stub(:save).and_return(false)
        post :create, {:location => {}}, valid_session
        assigns(:location).should be_a_new(Location)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Location.any_instance.stub(:save).and_return(false)
        post :create, {:location => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested location" do
        location = Location.create! valid_attributes
        # Assuming there are no other locations in the database, this
        # specifies that the Location created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Location.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => location.to_param, :location => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested location as @location" do
        location = Location.create! valid_attributes
        put :update, {:id => location.to_param, :location => valid_attributes}, valid_session
        assigns(:location).should eq(location)
      end

      it "redirects to the location" do
        location = Location.create! valid_attributes
        put :update, {:id => location.to_param, :location => valid_attributes}, valid_session
        response.should redirect_to(location)
      end
    end

    describe "with invalid params" do
      it "assigns the location as @location" do
        location = Location.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Location.any_instance.stub(:save).and_return(false)
        put :update, {:id => location.to_param, :location => {}}, valid_session
        assigns(:location).should eq(location)
      end

      it "re-renders the 'edit' template" do
        location = Location.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Location.any_instance.stub(:save).and_return(false)
        put :update, {:id => location.to_param, :location => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested location" do
      location = Location.create! valid_attributes
      expect {
        delete :destroy, {:id => location.to_param}, valid_session
      }.to change(Location, :count).by(-1)
    end

    it "redirects to the locations list" do
      location = Location.create! valid_attributes
      delete :destroy, {:id => location.to_param}, valid_session
      response.should redirect_to(locations_url)
    end
  end

end
