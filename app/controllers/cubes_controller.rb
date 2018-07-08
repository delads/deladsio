class CubesController < ApplicationController

    before_action :build_sensor_image_map
    before_action :build_sensor_measure_map
    before_action :require_admin_user, only: [:index, :create, :destroy]


    def index
        @cubes = Cube.all
        @sensors = Sensor.all
        @makers = Maker.all

    end

    def new
        @cube = Cube.new
    end

    def edit
        @cube = Cube.find(params[:id])
    end

    def register
        
    end

    def registerSubmit

        #Let's check to see if this sigfox device has already been regitered
        sigfox_id = params[:sigfox_id]

        cube = Cube.where(sigfox_id: sigfox_id)
        if(cube == nil)
            flash[:danger] = "Device '" + sigfox + "' cannot be found. Please contact support"
            render 'register'
        end

        if(cube.maker_id != nil)
            flash[:danger] = "Device '" + sigfox + "' is already registered"
            render 'register'
        end


        if @cube.update
            flash[:success] = "You have successfully registered your Cube"
            redirect_to cube_path(@cube)
        else
            flash[:danger] = "There were problems registering your Cube. Please contact support"
            render 'register'
        end
    end

    #only the administrator can create EcoCubes (creates an entry with the sigfox id and leaves the maker blank)
    def create

        #Let's make sure the cube is not already created
        sigfox_id = params[:sigfox_id]
        cube = Cube.where(sigfox_id: sigfox_id)

        if(cube.any?)
            flash[:danger] = "Cube already exists with this ID"
            render 'new'
        end

        @cube = Cube.new(cube_params)
        if(@cube.save)
            flash[:success] = "Cube created!"
            redirect_to cubes_path
        else
            flash[:danger] = "Problem creating cube. Please try again"
            render 'new'
            
        end
    end


    def destroy
        cube = Cube.find(params[:id])

        #Let's delete all sensors associated with this cube before deletion
        @sensors = Sensor.where(cube_id: params[:id])

        @sensors.each do |sensor|
            
            # Sensors have many triggers so, we need to delete these also
            @triggers = Triggers.where(sensor_id: sensor.id)
            @triggers.each do |trigger|
                trigger.delete
            end
            sensor.delete
        end

        cube.delete
        flash[:success] = "Cube deleted"
        redirect_to cubes_path

    end

    # If the user is admin, they will see an aditional button to delete 
    def update

        puts params[:id]

        cube = Cube.find(params[:id])
        
        if cube.update(cube_params)
            flash[:success] = "Your cube has been updated successfully"
            redirect_to cubes_path
          else
            render 'edit'
        end

    end


    # If the user is admin, they will see an aditional button to delete 
    def show
        puts params[:id]
        
        @cube = Cube.find(params[:id])
        @sensors = Sensor.where(cube_id: params[:id])
        

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

    def cube_params
        params.require(:cube).permit(:id, :name, :maker_id, :description, :sigfox_id, :board_id, :provisioned)
    end

    def require_admin_user
        if current_user == nil 
            flash[:danger] = "Only the Administrator can access this page"
            redirect_to login_path
        
        elsif current_user.makername != 'admin'
            flash[:danger] = "Only the Administrator can access this page"
            redirect_to login_path
        end
    
    end


end
