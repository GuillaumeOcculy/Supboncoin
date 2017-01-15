FactoryGirl.define do
  factory :user do
    first_name          { Faker::Name.first_name }
    last_name           { Faker::Name.last_name }
    sequence(:email)    { |n| "#{n}@supinfo.com" }
    sequence(:username) { |n| "#{Faker::Internet.user_name}-#{n}"}
    password            "password"
    is_admin            false
    sequence(:phone)    { |n| "#{Faker::PhoneNumber.phone_number}#{n}" }

    factory :admin do
      is_admin        true
    end

    factory :invalid_user do
      first_name      { nil }
    end
  end
end
