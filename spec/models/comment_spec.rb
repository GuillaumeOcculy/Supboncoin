require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'Validations' do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:post_id) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
  end

  context 'db' do
    context 'indexes' do
      it { is_expected.to have_db_index(:user_id) }
      it { is_expected.to have_db_index(:post_id) }
    end

    context 'columns' do
      it { is_expected.to have_db_column(:body).of_type(:text) }
      it { is_expected.to have_db_column(:post_id).of_type(:integer) }
      it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    end

    it 'has a valid factory' do
      expect(build(:comment)).to be_valid
    end
  end
end
