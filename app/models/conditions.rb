class Conditions < ActiveRecord::Base
  belongs_to :location
  attr_accessible :temp, :wind_direction, :wind_speed

  validates_presence_of :temp
  validates :wind_speed, :numericality => { :greater_than_or_equal_to => 0 }
  validates :wind_direction, :format => { 
  	:with => /^[NS]?[NSWE]?$/i,
  	:message => "Wind direction should consist of [NSWE]" }

  def self.updated_since(timestamp)
    self.where("created_at > ?", Time.at(timestamp))
  end

  def wind_direction=(dir)
  	write_attribute :wind_direction, dir.upcase
  end

  def formatted_time
  	read_attribute(:created_at).strftime("%H:%M %Y/%m/%d")
  end

  def timestamp
  	read_attribute(:created_at).to_i
  end
end
