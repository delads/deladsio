class BillingController < ApplicationController

    before_action :set_maker

    
    def index
        
    end

    def order

      @product = params[:product]
      @number_of_cubes = params[:amount].to_i

      #let's hardcode the prices for now
      @total_cube_price = @number_of_cubes.to_i * 75
      @extra_subscriptions = 0


      if(@number_of_cubes > 1)
          @number_of_extra_cubes = @number_of_cubes - 1
          @extra_subscriptions = @number_of_extra_cubes * 5
      end

      @total_subscription_price = (20 + @extra_subscriptions) 
      @total_price = @total_cube_price + @total_subscription_price

    end

    
  def set_maker
    @maker = current_user

    if(current_user != nil)
      flash[:demo] = "Test Mode for Stripe Billing only"
    else
        flash[:demo] = "Test Mode for Stripe Billing only. Please log in to test this functionality"
    end

  end


end