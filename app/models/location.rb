class Location < ActiveRecord::Base
  attr_accessible :name, :current_conditions
  has_many :conditions
  validates :name, 
  						presence: true, 
  						format: { with: /\w+/ }
  default_scope order('name ASC')

  def current_conditions
  	conditions.last
  end

  def current_conditions=(conds)
  	conditions.build(:temp => conds[:temp], 
  		:wind_direction => conds[:wind_direction],
  		:wind_speed => conds[:wind_speed] )
  end
end
