require 'rails_helper'

RSpec.describe User, type: :model do

  it { is_expected.to allow_value('19191919@supinfo.com').for(:email) }
  it { is_expected.to_not allow_value('aaa19191919@supinfo.com').for(:email) }
  it { is_expected.to_not allow_value('foo@supinfo.com').for(:email) }
  it { is_expected.to_not allow_value('foo+bar@supinfo.com').for(:email) }
  it { is_expected.to_not allow_value('foo@example.com').for(:email) }
  it { is_expected.to_not allow_value('foosupinfo.com').for(:email) }

  # describe '#email' do
  #   it 'stores email in downcase and removes whitespace' do
  #     user = create(:user, email: '191919@supinfo.com')
  #     expect(user.email).to eq '191919@supinfo.com'
  #   end
  # end

  describe '#username' do
    it 'stores username in downcase and removes whitespace' do
      user = create(:user, username: 'jo h n Do e')
      expect(user.username).to eq 'johndoe'
    end
  end

  context "Validations" do

    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }

    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_uniqueness_of(:username) }
    it { is_expected.to validate_uniqueness_of(:phone) }

  end

  context 'db' do
    context 'indexes' do
      it { is_expected.to have_db_index(:email) }
      it { is_expected.to have_db_index(:username) }
    end

    context 'columns' do
      it { is_expected.to have_db_column(:first_name).of_type(:string)}
      it { is_expected.to have_db_column(:last_name).of_type(:string)}
      it { is_expected.to have_db_column(:email).of_type(:string)}
      it { is_expected.to have_db_column(:username).of_type(:string)}
      it { is_expected.to have_db_column(:password_digest).of_type(:string)}
      it { is_expected.to have_db_column(:phone).of_type(:string)}
      it { is_expected.to have_db_column(:is_admin).of_type(:boolean)}
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
