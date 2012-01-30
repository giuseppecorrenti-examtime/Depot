class StoreController < ApplicationController
  def index
    increment_session_counter
    @products = Product.all
  end
end
