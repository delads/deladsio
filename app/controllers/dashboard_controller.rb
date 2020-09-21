class DashboardController < ApplicationController

  before_action :build_sensor_image_map
  before_action :build_sensor_measure_map
  # before_action :require_user
  before_action :set_maker
  
  def index

    # Let's give people a demo account so they can see what it's all about
    demo_account = Maker.where(email: "enniskerry@ecocube.io").first

      if(current_user != nil)   

        @sensors = Sensor.where(maker_id: current_user.id)
        @timeseries = TimeSeries.where(sensor_id: @sensors, created_at: 7.days.ago..1.second.ago).order(:created_at)
        @cubes = Cube.where(maker_id: current_user.id)
      else

        # flash[:danger] = "Please log in to access your dashboard"
        # redirect_to login_path

        @sensors = Sensor.where(maker_id: demo_account )
        @timeseries = TimeSeries.where(sensor_id: @sensors, created_at: 7.days.ago..1.second.ago).order(:created_at)
        @cubes = Cube.where(maker_id: demo_account.id )

      end

     # @hourlyAverage = TimeSeries.group(:sensor_id, "date_trunc('hour', created_at)").average('property_value')

     # redirect_to cube_path(cube)

  end

  def build_sensor_image_map
    @sensor_image = Hash.new
    @sensor_image["Temperature"] = "icons8-thermometer-automation-96.png"
    @sensor_image["Pressure"] = "icons8-pressure-96.png"
    @sensor_image["Humidity"] = "icons8-rain-96.png" 
    @sensor_image["WaterproofTemperature"] = "icons8-thermometer-automation-96.png"
    @sensor_image["SoilMoisture"] = "icons8-water-96.png"
    @sensor_image["LightIntensity"] = "icons8-light-on-96.png"
    @sensor_image["AirQuality"] = "icons8-air-quality-96.png"
    @sensor_image["Power"] = "icons8-electrical-96.png"
    @sensor_image["Battery"] = "icons8-charging-battery-96.png"

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
      @sensor_measure["Battery"] = ""

  end

  def set_maker
    @maker = current_user
  end



end
