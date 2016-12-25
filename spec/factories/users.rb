FactoryGirl.define do
  factory :user do
    first_name        { Faker::Name.first_name }
    last_name         { Faker::Name.last_name }
    email             { Faker::Internet.email }
    username          {"#{first_name}-#{last_name}"}
    password_digest   "password"
    is_admin          false
    phone             { Faker::PhoneNumber.phone_number }

    factory :admin do
      is_admin        true
    end
  end
end
