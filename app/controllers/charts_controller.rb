class ChartsController < ApplicationController
  # before_action :require_user
  
  def index
    
  end

  def show

    makerId = current_user

    if(current_user == nil)
      flash[:demo] = "Please log in to edit existing sensors"

      makerId = Maker.where(email: "don@delads.com").first.id
    end

    @sensor = Sensor.find(params[:id])
    cube_id = @sensor.cube_id

    @sensors = Sensor.where(maker_id: makerId, cube_id: cube_id)
    

    if(params[:compare_graph] != nil)
      @sensorCompare = Sensor.find(params[:compare_graph])
      @timeseriesCompare = TimeSeries.where("sensor_id = '" + @sensorCompare.id.to_s + "'").order(:created_at)
    else
      @sensorCompare = Sensor.none
      @timeseriesCompare = TimeSeries.none
    end

    @timeseries = TimeSeries.where("sensor_id = '" + @sensor.id.to_s + "'").order(:created_at)
  end
  
end

