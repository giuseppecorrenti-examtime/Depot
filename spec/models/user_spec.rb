require 'spec_helper'

describe User do
 context "a new user" do
    it "should be valid if all fields supplied" do
      user = FactoryGirl.build(:user)
      user.should be_valid
    end

    it "should not be valid if name is blank" do
      user = FactoryGirl.build(:user, :name => "")
      user.should_not be_valid
    end

    it "should not be valid if name already taken" do
      user = FactoryGirl.create(:user)
      user_duplicate_username = FactoryGirl.build(:user, :name => user.name)
      user_duplicate_username.should_not be_valid
    end

    it "should not be valid if email already taken" do
      user = FactoryGirl.create(:user)
      user_duplicate_email = FactoryGirl.build(:user, :email => user.email)
      user_duplicate_email.should_not be_valid
    end

    it "should accept valid email addresses" do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
        valid_email_user = FactoryGirl.build(:user, :email => address)
        valid_email_user.should be_valid
      end
    end

    it "should reject invalid email addresses" do
      addresses = %w[user@foo;com user_at_foo.org example.user@foo.]
      addresses.each do |address|
        invalid_email_user = FactoryGirl.build(:user, :email => address)
        invalid_email_user.should_not be_valid
      end
    end
    
    it "should only have customer role after creation" do
      user = FactoryGirl.create(:user)
      user.roles.count == 1
      user.roles.include?(Role.find_by_name("customer"))
    end

    it "should be able to identify if the user has a particular role" do
      user = FactoryGirl.create(:user)
      user.role? user.roles[0].name.to_sym == true
    end

  end

  context "an existing user" do

    context "with the admin privilege" do
      before :each do
        @customer = FactoryGirl.build(:admin_user)
        @admin_role = Role.find_by_name("admin")
      end
    end

    context "with no system_admin privilege" do
      before :each do
        @user = FactoryGirl.build(:user)
      end     
    end

  end

end
