module IntegrationTestHelper
  
  [:admin, :customer].each { |r| Role.create(:name => r) }

  def register(user)
    within("form") do
      fill_in "user_name", :with => user.name
      fill_in "user_email", :with => user.email
      fill_in "user_password", :with => user.password
      fill_in "user_password_confirmation", :with => user.password
    end
    save_and_open_page
    click_button "Create User"   
  end
  
  def login(user)
    within("form") do 
      fill_in "user_email", :with => user.email
      fill_in "user_password", :with => user.password
    end
    click_button "Sign in"
  end
end