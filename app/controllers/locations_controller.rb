class LocationsController < ApplicationController
  # GET /locations
  def index
    @locations = Location.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /locations/1
  def show
    @location = Location.find(params[:id])
    @conditions = @location.current_conditions

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /locations/1/history
  def history
    @location = Location.find(params[:id])
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

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
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

  # PUT /locations/1
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /locations/1
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url }
    end
  end
end
