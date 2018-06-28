class ChartsController < ApplicationController
  # before_action :require_user
  
  def index
    
  end

  def show

    if(current_user == nil)
      flash[:demo] = "Demo Dashboard. These are actual sensor readings in a 
                        remote location on the river bank of a small Irish village.
                        Demo accounts cannot edit existing sensors"
    end

    @sensors = Sensor.all
    @sensor = Sensor.find(params[:id])

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

