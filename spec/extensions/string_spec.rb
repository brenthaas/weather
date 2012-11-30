require 'spec_helper'

describe "String" do
	describe "#convert_spaces" do
		it "replaces spaces with '_'" do
			"this is a string".convert_spaces.should == "this_is_a_string"
		end
	end
	describe "#restore_spaces" do
		it "replaces '_' with a space" do
			"this_has_spaces".restore_spaces.should == "this has spaces"
		end
	end
end