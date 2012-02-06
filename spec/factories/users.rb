FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "gip#{n}@gip.com"}
    sequence(:name) {|n| "gip#{n}"}    
    password "testytest"
    password_confirmation { |u| u.password }
  end
  
  factory :admin_user, :parent => :user do
    roles [Role.find_or_create_by_name("admin")] 
  end
  
  factory :customer_user, :parent => :user do
    roles [Role.find_or_create_by_name("customer")] 
  end
  
end
