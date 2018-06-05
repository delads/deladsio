class ChartsController < ApplicationController
  before_action :require_user
  
  def index
    
  end

  def show

    @sensor = Sensor.find(params[:id])
    @timeseries = TimeSeries.where("sensor_id = '" + @sensor.id.to_s + "'")
  end
  
end

