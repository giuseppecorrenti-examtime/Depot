require 'spec_helper'

describe Role do
  context "creating a new role" do

    it "should be valid when all required fields supplied" do
      role = FactoryGirl.build(:role)
      role.should be_valid
    end

    it "should be invalid when name is blank" do
      role = FactoryGirl.build(:role, :name => "")
      role.should_not be_valid
    end
    
    it "should not be valid if name already taken" do
      role = FactoryGirl.create(:role)
      role_duplicate_name = FactoryGirl.build(:role, :name => role.name)
      role_duplicate_name.should_not be_valid
    end
    
  end
end
