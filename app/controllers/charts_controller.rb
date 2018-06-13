class ChartsController < ApplicationController
  before_action :require_user
  
  def index
    
  end

  def show

    @sensors = Sensor.all
    @sensor = Sensor.find(params[:id])

    if(params[:compare_graph] != nil)
      @sensorCompare = Sensor.find(params[:compare_graph])
      @timeseriesCompare = TimeSeries.where("sensor_id = '" + @sensorCompare.id.to_s + "'")
    else
      @sensorCompare = Sensor.none
      @timeseriesCompare = TimeSeries.none
    end

    @timeseries = TimeSeries.where("sensor_id = '" + @sensor.id.to_s + "'")
  end
  
end

