require 'rails_helper'

RSpec.describe User, type: :model do

  context "Validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }

    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:phone) }

  end

  context 'db' do
    context 'indexes' do
      it { should have_db_index(:email) }
      it { should have_db_index(:username) }
    end

    context 'columns' do
      it { should have_db_column(:first_name).of_type(:string)}
      it { should have_db_column(:last_name).of_type(:string)}
      it { should have_db_column(:email).of_type(:string)}
      it { should have_db_column(:username).of_type(:string)}
      it { should have_db_column(:password_digest).of_type(:string)}
      it { should have_db_column(:phone).of_type(:string)}
      it { should have_db_column(:is_admin).of_type(:boolean)}
    end
  end
  
  describe 'has a secure password' do
    it { should have_secure_password }
  end

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "user should not be admin" do
    user = build(:user)
    expect(user.is_admin).to_not be true
  end

  it "User has a #name" do
    user = create(:user)
    expect(user.name).to eq("#{user.first_name} #{user.last_name}")
  end

end
