require 'spec_helper'

describe "locations/index" do
  before(:each) do
    assign(:locations, [
      FactoryGirl.create(:location, :with_conditions, :name =>"MyText"),
      FactoryGirl.create(:location, :with_conditions, :name =>"MyText")])
  end

  it "renders a list of locations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
