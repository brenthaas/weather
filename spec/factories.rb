FactoryGirl.define do
	factory :location do
		sequence(:name) { |num| "Test Location #{num}"}
	end

	factory :conditions do
		temp 80
		wind_speed 15
		wind_direction 'SW'
	end
end