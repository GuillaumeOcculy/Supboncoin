FactoryGirl.define do
  factory :user do
    first_name "MyString"
    last_name "MyString"
    email "MyString"
    username "MyString"
    password_digest "MyString"
    is_admin false
    phone "MyString"
  end
end
