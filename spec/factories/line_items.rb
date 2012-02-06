FactoryGirl.define do
  factory :line_item do
    
    association :product
    association :cart
  end
end
