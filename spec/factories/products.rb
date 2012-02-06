FactoryGirl.define do
  factory :product do
    sequence(:title) {|n| "product#{n}"} 
    description 'dummyProduct'
    sequence(:image_url) {|n| "img#{n}.jpg"}
    price '12.00'
  end

end
