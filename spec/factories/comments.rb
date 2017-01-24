FactoryGirl.define do
  factory :comment do
    body     { Faker::Lorem.paragraph }

    # Associations
    post
    user

    factory :invalid_comment do
      content   nil
    end
  end
end
