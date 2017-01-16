FactoryGirl.define do
  factory :post do
    name         { Faker::Commerce.product_name }
    description  { Faker::Lorem.paragraph }
    price        { Faker::Commerce.price }

    # Associations
    category
    user


    factory :invalid_post do
      name    nil
    end
  end
end
