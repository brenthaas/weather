FactoryGirl.define do

	factory :conditions do
		location
		temp 80
		wind_speed 15
		wind_direction 'SW'
	end

	factory :location do
		sequence(:name) { |num| "Test Location #{num}"}
	end

	trait :with_conditions do
		ignore do
			conditions_count 15
		end

		after(:create) do |location, evaluator|
			FactoryGirl.create_list(:conditions, 
				evaluator.conditions_count, 
				:location => location)
		end
	end
end