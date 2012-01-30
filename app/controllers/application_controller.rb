class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_cart
  
  private
    def current_cart
      @current_cart = Cart.find(session[:cart_id])      
    rescue ActiveRecord::RecordNotFound
      @current_cart = Cart.create
      session[:cart_id] = @current_cart.id
    end
    @current_cart
end
