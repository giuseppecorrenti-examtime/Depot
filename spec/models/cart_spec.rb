require 'spec_helper'

describe Cart do
  
  context "creation" do
    it "is not valid without an unique user_id" do      
      cart = FactoryGirl.create(:cart)
      cart2 = FactoryGirl.build(:cart, :user_id => cart.user_id)     
      cart2.should_not be_valid      
    end       
  end  
  
  context "updating" do
   
    it "is adding a new line item and setting its quantity to 1 when a new product is added" do  
      product = FactoryGirl.build(:product)
      cart = FactoryGirl.build(:cart)         
      line_item = cart.add_product(product.id)   
      line_item.save           
      cart.line_items.find_by_product_id(product.id).quantity.should equal 1     
    end
    
    it "is incrementing quantity by one when a product alraedy in the cart is added" do
      cart = FactoryGirl.build(:cart)  
      product = FactoryGirl.build(:product)  
      quantity = 0        
      2.times do             
        line_item = cart.add_product(product.id)
        line_item.save
        quantity = line_item.quantity        
      end      
      cart.line_items.find_by_product_id(product.id).quantity.should equal 2     
    end
  end
  
  context "destroying" do
    it "destroys the line items still present in the cart" do
      cart = FactoryGirl.build(:cart)  
      product = FactoryGirl.build(:product)             
      2.times do             
        line_item = cart.add_product(product.id)
        line_item.save                
      end
      cart.destroy
      cart.line_items.find_by_product_id(product.id).should be nil    
    end
  end
  
      
end
