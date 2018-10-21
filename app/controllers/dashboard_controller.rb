class DashboardController < ApplicationController

  before_action :build_sensor_image_map
  before_action :build_sensor_measure_map
  # before_action :require_user
  before_action :set_maker
  
  def index

    # Let's give people a demo account so they can see what it's all about
   demo_account = Maker.where(email: "enniskerry@ecocube.io").first

      if(current_user != nil)   

        @sensors = Sensor.where(maker_id: current_user)
        @timeseries = TimeSeries.where(sensor_id: @sensors, created_at: 7.days.ago..1.second.ago)
        @cubes = Cube.where(maker_id: current_user)
      else

        # flash[:danger] = "Please log in to access your dashboard"
        # redirect_to login_path

        @sensors = Sensor.where(maker_id: demo_account.id )
        @timeseries = TimeSeries.where(sensor_id: @sensors, created_at: 7.days.ago..1.second.ago)
        @cubes = Cube.where(maker_id: demo_account.id )

      end

      @sensors = Sensor.where(maker_id: current_user)
      @timeseries = TimeSeries.where(sensor_id: @sensors, created_at: 7.days.ago..1.second.ago)
     # @hourlyAverage = TimeSeries.group(:sensor_id, "date_trunc('hour', created_at)").average('property_value')

     # redirect_to cube_path(cube)

  end

  def build_sensor_image_map
    @sensor_image = Hash.new
    @sensor_image["Temperature"] = "https://png.icons8.com/material/1600/thermometer-automation.png"
    @sensor_image["Pressure"] = "https://png.icons8.com/material/1600/pressure.png"
    @sensor_image["Humidity"] = "https://png.icons8.com/material/1600/moisture.png" 
    @sensor_image["WaterproofTemperature"] = "https://png.icons8.com/material/1600/thermometer-automation.png"
    @sensor_image["SoilMoisture"] = "https://png.icons8.com/material/1600/watering-can.png"
    @sensor_image["LightIntensity"] = "https://png.icons8.com/material/1600/do-not-expose-to-sunlight.png"
    @sensor_image["AirQuality"] = "https://png.icons8.com/material/1600/air-quality.png"

  end

  def build_sensor_measure_map
   @sensor_measure = Hash.new
      @sensor_measure["Temperature"] = "&deg;C"
      @sensor_measure["Pressure"] = "hPa"
      @sensor_measure["Humidity"] = "%"  
      @sensor_measure["WaterproofTemperature"] = "&deg;C"
      @sensor_measure["SoilMoisture"] = ""
      @sensor_measure["LightIntensity"] = ""
      @sensor_measure["Air Quality"] = ""

  end

  def set_maker
    @maker = current_user
  end



end