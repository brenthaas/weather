class Conditions < ActiveRecord::Base
  belongs_to :location
  attr_accessible :temp, :wind_direction, :wind_speed

  validates :wind_speed, :numericality => { :greater_than_or_equal_to => 0 }
  validates :wind_direction, :format => { 
  	:with => /^[NS]?[NSWE]?$/i,
  	:message => "Wind direction should consist of [NSWE]" }

  def wind_direction=(dir)
  	write_attribute :wind_direction, dir.upcase
  end
end
