class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :current_cart
  
  private    
    def current_cart
      @current_cart = Cart.find(session[:cart_id])      
    rescue ActiveRecord::RecordNotFound
      @current_cart = Cart.create
      session[:cart_id] = @current_cart.id
      @current_cart
    end
    
    def reset_session_counter
      session[:counter] = 0
    end
  
    def increment_session_counter
      if session[:counter].nil?
        session[:counter] = 1
      else 
        session[:counter] += 1
      end
    end
end
