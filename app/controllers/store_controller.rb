class StoreController < ApplicationController
  
      
  def index
    increment_session_counter
    @products = Product.all
    if can? :manage, @cart
      @cart = current_cart
    end           
  end
end
