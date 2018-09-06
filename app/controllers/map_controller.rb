class MapController < ApplicationController

    before_action :build_sensor_map
    before_action :build_sensor_measure_map
    

def index
    # Let's give people a demo account so they can see what it's all about
    demo_account = Maker.where(email: "demo@ecocube.io").first

    if(current_user != nil)
     @sensors = Sensor.where(maker_id: current_user)
     @cubes = Cube.where(maker_id: current_user)
    else
      @sensors = Sensor.where(maker_id: demo_account.id )
      @cubes = Cube.where(maker_id: demo_account.id )
      flash[:demo] = "Demo Dashboard. These are actual sensor readings in a 
                      remote location on the river bank of a small Irish village.
                      Demo accounts cannot edit existing sensors"
    end

end


def build_sensor_map
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



end