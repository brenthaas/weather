class ConditionsController < ApplicationController
	def index
		last_entry = params[:since] || 0
		@conditions = Conditions.where("created_at > ?", Time.at(last_entry.to_i))
		respond_to do |format| 
      format.json { render json: @conditions, 
      											:include => {:location => {:only => :name}}, 
      											:methods => [:formatted_time, :timestamp] }
    end
	end	
end