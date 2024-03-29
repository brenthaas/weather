class LocationsController < ApplicationController
  # GET /locations
  def index
    @locations = Location.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /locations/San_Francisco
  def show
    @location = Location.find_by_name(params[:id].restore_spaces)
    @conditions = @location.current_conditions

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /locations/San_Francisco/history
  def history
    @location = Location.find_by_name(params[:id].restore_spaces)
    if(params[:since])
      @conditions_list = @location.conditions.where("created_at > ?", Time.at(params[:since].to_i))
    else
      @conditions_list = @location.conditions
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @conditions_list, methods: [:formatted_time, :timestamp] }
    end
  end

  # GET /locations/new
  def new
    @location = Location.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /locations/San_Francisco/edit
  def edit
    @location = Location.find_by_name(params[:id].restore_spaces)
  end

  # POST /locations
  def create
    @location = Location.new(params[:location])

    respond_to do |format|
      if @location.save
        format.html { redirect_to locations_url, notice: 'Location was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /locations/San_Francisco
  def update
    @location = Location.find_by_name(params[:id].restore_spaces)

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /locations/San_Francisco
  def destroy
    @location = Location.find_by_name(params[:id].restore_spaces)
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url }
    end
  end
end
