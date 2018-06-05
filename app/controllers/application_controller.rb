class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  
  #protect_from_forgery :except => :webhook
  #protect_from_forgery :except => :pay
  
  helper_method :current_user, :logged_in? 


  def current_user
    @current_user ||= Maker.find(session[:maker_id]) if session[:maker_id]
  end
  
  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      # flash[:danger] = "You used be logged in to perform that action"
      redirect_to login_path
    end
  end
  
end