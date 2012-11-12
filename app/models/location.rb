class Location < ActiveRecord::Base
  attr_accessible :name
  has_many :conditions

  def current_weather
  	conditions.last
  end

  def past_weather(count=10)
  	conditons.last(10)
  end
end
