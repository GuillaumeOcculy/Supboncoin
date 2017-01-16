require 'rails_helper'

RSpec.describe Post, type: :model do


  context 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:user) }

    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }

    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:user) }
  end

  describe '#name' do
    it 'stores name in capitalize and removes whitespaces' do
      post = create(:post, name: 'Je vends Un Casque   ')
      expect(post.name).to eq 'Je vends un casque'
    end
  end

  context 'db' do
    context 'indexes' do
      it { is_expected.to have_db_index(:name)}
      it { is_expected.to have_db_index(:category_id)}
      it { is_expected.to have_db_index(:user_id)}
    end

    context 'columns' do
      it { is_expected.to have_db_column(:name).of_type(:string) }
      it { is_expected.to have_db_column(:description).of_type(:text) }
      it { is_expected.to have_db_column(:price).of_type(:float) }
      it { is_expected.to have_db_column(:category_id).of_type(:integer) }
      it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    end
  end

  it 'has a valid factory' do
    expect(build(:post)).to be_valid
  end
end
