require 'spec_helper'
require_relative '../helpers/integration_test_helper.rb'

describe "UserSessions" do

  include IntegrationTestHelper
  before :each do
    [:admin, :customer].each { |r| Role.create(:name => r) }
    @test_user = FactoryGirl.create(:user)
  end
  
/#
============================================ unauthenticated ===========================================
#/ 

  context "unauthenticated user" do
    
    it "should have 'Sign in' link available in dropdown-menu" do
      visit store_path
      within("ul.dropdown-menu") do
        page.should have_link "Sign in"
      end
    end

    it "should be redirected to sign in page when 'Sign in' is clicked" do
      visit store_path  
      click_link "Sign in"
      page.should have_selector("h2", :text => "Sign in")
      page.current_path == new_user_session_path
    end
    
    it "should have 'Sign up' link available in dropdown-menu" do
      visit store_path
      within("ul.dropdown-menu") do
        page.should have_link "Sign up"
      end
    end

    it "should be redirected to sign up page when 'Sign up' is clicked" do
      visit store_path  
      click_link "Sign up"
      page.should have_selector("h2", :text => "Sign up")
      page.current_path == new_user_registration_path
    end


/#
============================================ SIGN IN ===========================================
#/    
    context "sign in page" do
      
      it "should have username and password fields" do
        visit new_user_session_path
        page.should have_content "email"
        page.should have_content "password"
        page.should have_selector("#user_email")
        page.should have_selector("#user_password")
      end
      
      it "should have a 'Remember me' checkbox" do
        visit new_user_session_path
        page.should have_selector("#user_remember_me")
      end

    end
    
  end

/#
============================================ authenticated ===========================================
#/    

  context "authenticated user" do
    before :each do
      visit new_user_session_path
      login(@test_user)
    end

    it "should display the username of the logged in user in cart title" do
      within(".cart_title") do
          page.should have_content(@test_user.name)
      end    
    end

    it "should have a 'Logout' link available in dropdown-menu" do
      within("ul.dropdown-menu") do
        page.should have_link "Logout"
      end
    end

    it "should destroy the users session when 'Sign out' is clicked" do
      click_link "Logout"
      page.current_path == new_user_session_path
      page.should have_content "Sign in"
    end

    it "should have a 'Setting' link available" do
      within("ul.dropdown-menu") do
        page.should have_link "Settings"
      end
    end

    it "should redirect to user details screen when 'Settings' clicked" do
      click_link "Settings"
      page.current_path == edit_user_registration_path
      page.should have_content "Update User"
    end
        
  end
end
