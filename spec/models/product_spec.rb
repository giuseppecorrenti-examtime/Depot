require 'spec_helper'

describe Product do
  context "creation" do
    it "is valid with valid attributes" do
      product = FactoryGirl.build(:product)
      product.should be_valid    
    end
    
    it "is not valid without a title" do
      product = FactoryGirl.build(:product, :title => nil)
      product.should_not be_valid
    end
    
    it "is not valid without a description" do
      product = FactoryGirl.build(:product, :description => nil)
      product.should_not be_valid
    end
    
    it "is not valid without a image url" do
      product = FactoryGirl.build(:product, :image_url => nil)
      product.should_not be_valid
    end
    
    it "is not valid with a price less than or equal to 0" do
      prices = [ 0 ,-1 ]
      prices.each do |price|
        product = FactoryGirl.build(:product, :price => price)  
        product.should_not be_valid
      end    
    end
    
    
    it "is not valid with an image that is not jpg, png or gif" do
      urls = %w{ fred.doc fred.gif/more fred.gif.more }
      urls.each do |url|
        product = FactoryGirl.build(:product, :image_url => url )
        product.should_not be_valid
      end
    end  
    
    it "is not valid without an unique title" do
      product = FactoryGirl.create(:product)    
      product_2 = FactoryGirl.build(:product, :title => product.title)
      product_2.should_not be_valid
    end
  end
  
  context "destruction" do
    it "is allowed if there are no reference to any line items" do
      product = FactoryGirl.create(:product)
      line_item = FactoryGirl.create(:line_item, :product => product)
      line_item.destroy   
      product.destroy.should == product
    end
    
    it "is not allowed if there are still references to any line items" do
      product = FactoryGirl.create(:product)
      line_item = FactoryGirl.create(:line_item, :product => product)         
      product.destroy.should_not == product
    end    
   
  end
end