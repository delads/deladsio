class MakersController < ApplicationController
  before_action :set_maker, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update]
  before_action :require_admin_user, only: [:index]
  before_action :build_sensor_map, only: [:index]
  before_action :build_sensor_measure_map, only: [:index]
  before_action :set_stripe_env, only: [:create]

  

  
  
  def index
    @makers = Maker.all

  end
  
  def new 
    @maker = Maker.new

    

  end 
  
  def destroy
    
    @maker = Maker.find(params[:id])
     
    # Let's delete all sensors belonging to the user first
    @sensors = @maker.sensors
    
    @sensors.each do |t|
      t.delete
    end
    
    @maker.delete
    flash[:success] = "Maker deleted"
    redirect_to makers_path
   
  end
    
    
  
  def create

    #Let's make sure this email has not been taken before (prevevnt someone from creating more than one account)
    email = params[:email]
    makers = Maker.where(email: email)

    if (makers)
      flash[:danger] = "email is already taken"
      @maker = Maker.new
      render 'new'
    else

      @maker = Maker.new(maker_params)


      #Let's create this maker as a customer object on Stripe
      customer = Stripe::Customer.create({
        email: @maker.email
      })

      @maker.stripe_customer_id = customer.id

      if @maker.save
        flash[:success] = "Your account has been created successfully"
        session[:maker_id] = @maker.id

        redirect_to maker_path(@maker)
      else
        render 'new'
      end
    end


  end
  
  def edit

  end

  def update
    if @maker.update(maker_params)
      flash[:success] = "Your profile has been updated successfully"
      redirect_to maker_path(@maker)
    else
      render 'edit'
    end
  end
  
  
  def show

    @sensors = @maker.sensors
    
    stripe_customer_id = @maker.stripe_customer_id

    #if we don't already have a Stripe customer id associated with this maker
    #let's create one

    if(stripe_customer_id == nil)
      customer = nil
    else
      customer = Stripe::Customer.retrieve(stripe_customer_id)
    end

    puts customer

    if(customer == nil || customer.deleted) 
      customer = Stripe::Customer.create({email: @maker.email})
      @maker.stripe_customer_id = customer.id
      @maker.save
    end

    default_source = customer.default_source

    if(default_source != nil)
      @default_card = customer.sources.retrieve(default_source)
    end
    
    
  end
  

  private
    def maker_params
      params.require(:maker).permit(:makername, :email, :password)
    end
    
    def set_maker
      @maker = Maker.find(params[:id])
    end
    
    def require_same_user
      if current_user != @maker
        flash[:danger] = "You can only edit your own profile"
        redirect_to root_path
      end
    end
    
    def require_admin_user
      if current_user == nil 
        flash[:danger] = "You need to log in to view this page"
        redirect_to login_path
      
      elsif current_user.makername != 'admin'
        flash[:danger] = "Log in as admin to view this page"
        redirect_to login_path
      end

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

    def set_stripe_env
      Stripe.api_key = "sk_test_KNQxI3UCqUgrZIA5sK2cLvM9"
    end
    

end