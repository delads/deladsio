class TriggersController < ApplicationController
	before_action :require_user
	
	def index
		@triggers = Trigger.all
		@sensors = Sensor.all
	end

	def new
		@trigger = Trigger.new   
		@sensors = Sensor.all
	end

	def create
        @trigger = Trigger.new(trigger_params)
        @trigger.maker = current_user
     
        if @trigger.save
          flash[:success] = "Your trigger was created: " 
          redirect_to triggers_path
          
        else
          render :new
        end
	end

	def edit
		@trigger = Trigger.find(params[:id])
		@sensors = Sensor.all
	end

	def update
		@trigger = Trigger.find(params[:id])

        if @trigger.update(trigger_params)       
          flash[:success] = "Your trigger was updated successfully!"
          redirect_to triggers_path
        else
          render :edit
        end
    
	end

	def destroy
        trigger_id = params[:id]
        Trigger.find(trigger_id).destroy
        flash[:success] = "Trigger deleted"
        redirect_to triggers_path
    end
	


	def trigger_params
		params.require(:trigger).permit(:name, :sensor_id, :condition, :value, :email, :sms, :webhook_url)
	end
	

	
end
