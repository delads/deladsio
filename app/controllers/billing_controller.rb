class BillingController < ApplicationController

    before_action :set_maker
    before_action :set_stripe_env

    
    def index
   
    end

    def success

      #invalidate payment_intent
      session[:payment_intent] = nil


      flash[:success] = "Successful purchase"
      redirect_to dashboard_path

    end

    def checkout



      @product = params[:product]
      @number_of_cubes = params[:amount].to_i

      #let's hardcode the prices for now
      @total_cube_price = @number_of_cubes.to_i * 75
      @extra_subscriptions = 0


      if(@number_of_cubes > 1)
          @number_of_extra_cubes = @number_of_cubes - 1
          @extra_subscriptions = @number_of_extra_cubes * 5
      end

      @total_subscription_price = (6 + @extra_subscriptions) 
      @total_price= @total_cube_price + @total_subscription_price


      set_payment_intent


    end

    
  def set_maker
    @maker = current_user

    if(current_user != nil)
      flash[:demo] = "Test Mode for Stripe Billing only"
    else
        flash[:demo] = "Test Mode for Stripe Billing only. Please log in to test this functionality"
    end

  end

  def set_stripe_env
    Stripe.api_key = ENV["STRIPE_API_KEY"]
  end

  def set_payment_intent

    if(session[:payment_intent])

      @intent = Stripe::PaymentIntent.retrieve("#{session[:payment_intent]}")
      puts "PaymentIntent Status = " + @intent.status

      @intent.amount = @total_price * 100
      @intent.save

    else
      @intent = Stripe::PaymentIntent.create(
        amount: @total_price * 100,
        currency: 'eur',
        description: 'first ecocube purchase',
        allowed_source_types: ['card'],
    )

    session[:payment_intent] = @intent.id

    end

  end


end