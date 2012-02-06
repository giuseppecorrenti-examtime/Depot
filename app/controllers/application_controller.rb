class ApplicationController < ActionController::Base
  protect_from_forgery
    
  before_filter :current_cart

  # Authenticate user before being able to access the website
  before_filter :authenticate_user!
   
  #Change the layout depending on the context (Devise or not?)
  layout :set_from_context
  
  private
    def set_from_context
      if devise_controller?
        layout = 'public'
      else
        layout = 'application'
      end
      layout      
    end  
    
    def current_cart
      if current_user             
        @current_cart = Cart.find_by_user_id(current_user.id)
        if @current_cart.nil?             
          @current_cart = Cart.create          
          @current_cart.user_id = current_user.id
          @current_cart.save
        end             
        @current_cart    
      else
        nil
      end
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
