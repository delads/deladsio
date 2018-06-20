class BillingController < ApplicationController

    before_action :set_maker

    
    def index
        
    end

    
  def set_maker
    @maker = current_user
  end


end