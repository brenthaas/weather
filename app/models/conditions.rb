class Conditions < ActiveRecord::Base
  belongs_to :location
  attr_accessible :temp, :wind_direction, :wind_speed
end
