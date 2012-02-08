require 'spec_helper'
require_relative '../helpers/integration_test_helper.rb'

describe "Carts |" do
  
  include IntegrationTestHelper
  before :each do   
    [:admin, :customer].each { |r| Role.create(:name => r) }
    @user = FactoryGirl.create(:user) 
    @product = FactoryGirl.create(:product)
    @product2 = FactoryGirl.create(:product) 
    visit store_path
    login(@user)         
  end
  
  describe "add items |" do
    
    it "clicking Add to Cart button adds a new row (as a link) to the line items list if the list was empty", :js => true do            
      click_button("add_prod_#{@product.id}")      
      page.find("a.edit##{@product.id}").should have_content("#{@product.title}")                  
    end
    
    it "clicking Add to Cart button increments the quantity field of an existing row of the line items list if the product was already there", :js => true do            
      click_button("add_prod_#{@product.id}")
      click_button("add_prod_#{@product.id}")      
      page.find("tr.line_item_entry##{@product.id}").find("td#quantity").should have_content(2.to_s)         
    end
    
    it "clicking Add to Cart button adds a new row (as a link) to the line items list if the product was not previously there", :js => true do         
      click_button("add_prod_#{@product.id}")
      click_button("add_prod_#{@product2.id}")
      page.find("a.edit##{@product.id}").should have_content("#{@product.title}")
      page.find("a.edit##{@product2.id}").should have_content("#{@product2.title}")          
    end
        
  end
  
  describe "edit items |" do
    
    it "clicking the link with the title of the product shows a modal for editing the line item", :js => true  do
      click_button("add_prod_#{@product.id}")
      page.should have_css(".edit_line_item", :visible => false)
      page.find("a.edit##{@product.id}").click # Have to use find because this link will appear after the ajax call!      
      page.should have_css(".edit_line_item", :visible => true)
    end
    
    it "in the edit modal, filling the quantity field and clicking save updates the quantity on the cart", :js => true  do
      click_button("add_prod_#{@product.id}")
      page.find("a.edit##{@product.id}").click # Have to use find because this link will appear after the ajax call!      
      page.fill_in('line_item_quantity', :with => 2)
      click_button("Save")
      page.find("tr.line_item_entry##{@product.id}").find("td#quantity").should have_content(2.to_s)     
    end
    
    it "in the edit modal, filling the quantity field and clicking save updates the quantity on the cart", :js => true  do
      click_button("add_prod_#{@product.id}")
      page.find("a.edit##{@product.id}").click # Have to use find because this link will appear after the ajax call!      
      page.fill_in('line_item_quantity', :with => 2)
      page.find_field("line_item_quantity").value.should have_content("2")
      click_button("Cancel")
      page.find_field("line_item_quantity").value.should have_content("1")                 
    end
    
  end
  
  describe "remove items |" do
      
    it "clicking Empty Cart button removes all the rows from the line items list", :js => true do            
      click_button("delete_cart")      
      page.find("table#line_items").should_not have_css("tr.line_item_entry")                  
    end 
    
    it "clicking the Remove from Cart button in the edit line item modal removes the corresponding row from the line items list", :js => true do            
      click_button("add_prod_#{@product.id}")      
      page.find("a.edit##{@product.id}").click # Have to use find because this link will appear after the ajax call!
      click_button("delete_line_item") # Have to use find because this link will appear after the ajax call!click_button('Remove from Cart')            
      page.find("table#line_items").should_not have_css("tr.line_item_entry##{@product.id}")                  
    end       
        
  end
   
  
end
