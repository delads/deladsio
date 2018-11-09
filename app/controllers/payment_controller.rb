class PaymentController < ApplicationController

    before_action :set_maker
    before_action :set_stripe_env

    def index
       

    end

    def chargechard

        token = params[:stripeToken]


        redirect_to success_path


    end

    def addcreditcard

        token = params[:stripeToken]

        stripe_customer_id = @maker.stripe_customer_id
        customer = Stripe::Customer.retrieve(stripe_customer_id)
        customer.sources.create({:source => token})
        
        redirect_to payment_path
    end

    def deletecreditcard

        card_id = params[:card_id]
        stripe_customer_id = @maker.stripe_customer_id
        customer = Stripe::Customer.retrieve(stripe_customer_id)
        customer.sources.retrieve(card_id).delete()

        redirect_to payment_path

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



end
