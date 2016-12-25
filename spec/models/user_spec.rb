require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }

    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:phone) }
  end


  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "user should not be admin" do
    user = build(:user)
    expect(user.is_admin).to_not be true
  end

end
