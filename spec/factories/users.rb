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
      username      { nil }
    end

    factory :user_with_posts do
      transient do
        posts_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
      end
    end
  end
end
