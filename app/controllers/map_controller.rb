class MapController < ApplicationController

    before_action :build_sensor_map
    before_action :build_sensor_measure_map
    before_action :require_user
    

def index
    @sensor = Sensor.first
end


def build_sensor_map
    @sensor_class = Hash.new
    @sensor_class["Temperature"] = "fa fa-thermometer-3 fa-5x"
    @sensor_class["Humidity"] = "wi wi-humidity fa-5x"
    @sensor_class["Pressure"] = "wi wi-barometer fa-5x"
    @sensor_class["Soil Moisture"] = "wi wi-flood fa-5x"
    @sensor_class["Air Quality"] = "wi wi-dust fa-5x"
    @sensor_class["UV Index"] = "wi wi-hot fa-5x"
    @sensor_class["Rainfall"] = "wi wi-umbrella fa-5x"
    @sensor_class["Windspeed"] = "wi wi-strong-wind fa-5x"

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

end