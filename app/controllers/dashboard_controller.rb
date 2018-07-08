class DashboardController < ApplicationController

  before_action :build_sensor_image_map
  before_action :build_sensor_measure_map
  # before_action :require_user
  before_action :set_maker
  
  def index

    # Let's give people a demo account so they can see what it's all about
    demo_account = Maker.where(email: "demo@ecocube.io").first

    if(current_user != nil)
     @sensors = Sensor.where(maker_id: current_user)
    else
      @sensors = Sensor.where(maker_id: demo_account.id )
      flash[:demo] = "Demo Dashboard. These are actual sensor readings in a 
                      remote location on the river bank of a small Irish village.
                      Demo accounts cannot edit existing sensors"
    end
  end

  def build_sensor_image_map
    @sensor_image = Hash.new
    @sensor_image["Temperature"] = "https://png.icons8.com/material/1600/thermometer-automation.png"
    @sensor_image["Humidity"] = "https://png.icons8.com/material/1600/moisture.png"
    @sensor_image["Pressure"] = "https://png.icons8.com/material/1600/pressure.png"
    @sensor_image["Soil Moisture"] = "https://png.icons8.com/material/1600/sprout.png"
    @sensor_image["Air Quality"] = "https://png.icons8.com/material/1600/air-quality.png"
    @sensor_image["UV Index"] = "https://png.icons8.com/material/1600/do-not-expose-to-sunlight.png"
    @sensor_image["Rainfall"] = "https://png.icons8.com/material/1600/heavy-rain.png"
    @sensor_image["Windspeed"] = "https://png.icons8.com/material/1600/air.png"

  end

  def build_sensor_measure_map
    @sensor_measure = Hash.new
    @sensor_measure["Temperature"] = "&deg;C"
    @sensor_measure["Humidity"] = "%"
    @sensor_measure["Pressure"] = "hPa"
    @sensor_measure["Soil Moisture"] = ""
    @sensor_measure["Air Quality"] = ""
    @sensor_measure["UV Index"] = "mW/m2"
    @sensor_measure["Rainfall"] = "mm"
    @sensor_measure["Windspeed"] = "km/h"

  end

  def set_maker
    @maker = current_user
  end



end