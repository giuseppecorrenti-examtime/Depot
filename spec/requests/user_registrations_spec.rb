require 'spec_helper'
require_relative '../helpers/integration_test_helper.rb'

describe "UserRegistrations" do

  include IntegrationTestHelper
  before :each do
    [:admin, :customer].each { |r| Role.create(:name => r) }
    @test_user = FactoryGirl.create(:user)    
    @password = 'password123'
  end

/#
============================================ SIGN UP ===========================================
#/ 
    
    context "sign up page" do
  
      it "should have name, email, password and confirmation password fields" do
        visit new_user_registration_path
        page.should have_content "name"
        page.should have_content "email"
        page.should have_content "password"
        #page.should have_content "password confirmation" ??????????????????????
        page.should have_selector("#user_email")
        page.should have_selector("#user_name")
        page.should have_selector("#user_password_confirmation")
        page.should have_selector("#user_password")  
      end  
      
      
      it "should have a link to 'Sign in' page" do
        visit new_user_registration_path
        page.should have_link "Sign in"
      end
      
      it "should have a link to 'Forgot password' page" do
        visit new_user_registration_path
        page.should have_link "Forgot your password?"
      end
      
    end
/#
============================================ RESET PASSWORD ===========================================
#/        
    context "forgot your password page" do
      
      it "should have email field" do
        visit new_user_password_path
        page.should have_content "email"
        page.should have_selector("#user_email")
      end
      
      it "should have a link to 'Sign in' page" do
        visit new_user_password_path
        page.should have_link "Sign in"
      end
      
      it "should have a link to 'Sign up' page" do
        visit new_user_password_path
        page.should have_link "Sign up"
      end
            
    end  
end