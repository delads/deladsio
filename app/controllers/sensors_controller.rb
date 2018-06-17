class SensorsController < ApplicationController
before_action :set_sensor, only: [ :update, :show, :like, :destroy]
before_action :require_same_user, only: [ :update]
before_action :set_maker, only: [:show, :destroy]
before_action :build_sensor_map
before_action :require_user

    
    def index
        
        @sensors = Sensor.all
    
    end
    
    def show
        @sensor = Sensor.find(params[:id])
        @triggers = @sensor.triggers
        
        @shiftrsrc = "https://shiftr.io/" + @sensor.namespace + "/embed?zoom=1"
    end
    
    def temp
        @sensor = Sensor.find(params[:id])
        render :text => @sensor.property.value
    end
    
    def new
        @sensor = Sensor.new   
    end

    def edit
      @sensor = Sensor.find(params[:id])
      puts "At least it's calling edit"
    end
    
    def create
        @sensor = Sensor.new(sensor_params)
        @sensor.maker = current_user
     
        if @sensor.save
          flash[:success] = "Your sensor was created: " 
          redirect_to root_path
          
        else
          render :new
        end
    end
    

    
    def update
        if @sensor.update(sensor_params)       
          flash[:success] = "Your sensor was updated successfully!"
          redirect_to root_path
        else
          render :edit
        end
    
    end

    
    def destroy
        sensor_id = params[:id]
        TimeSeries.where("sensor_id" == sensor_id).delete_all
        Sensor.find(sensor_id).destroy
        flash[:success] = "Sensor deleted"
        redirect_to root_path
    end
    
    
  
    def sensor_params
      params.require(:sensor).permit(:name, :sensor_type, :namespace, :mqtt_token, :mqtt_topic, :sigfox_name, :altitude)
    end
    
    def set_sensor
      @sensor = Sensor.find(params[:id])
    end
    
    
    def set_maker
      @maker = @sensor.maker
    end
    
    
    def require_same_user
      if current_user != @sensor.maker
        flash[:danger] = "You can only edit your own sensors"
        redirect_to dashboard_path
      end
    end

    def build_sensor_map
      @sensor_class = Hash.new
      @sensor_class["Temperature"] = "fa fa-thermometer-3 fa-5x"
      @sensor_class["Humidity"] = "wi wi-humidity fa-5x"
      @sensor_class["Pressure"] = "wi wi-barometer fa-5x"
    end


end