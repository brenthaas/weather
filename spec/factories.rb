FactoryGirl.define do
	factory :location do
		sequence(:name) { |num| "Test Location #{num}"}
	end

end