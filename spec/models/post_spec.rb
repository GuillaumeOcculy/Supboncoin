require 'rails_helper'

RSpec.describe Post, type: :model do


  context 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:price) }

    it { is_expected.to belong_to(:category) }
  end

  describe '#name' do
    it 'stores name in capitalize and removes whitespaces' do
      post = create(:post, name: 'Je ve')
    end
  end
  context 'db' do
    context 'indexes' do
      it { is_expected.to have_db_index(:name)}
    end

    context 'columns' do
      it { is_expected.to have_db_column(:name).of_type(:string) }
      it { is_expected.to have_db_column(:content).of_type(:text) }
      it { is_expected.to have_db_column(:price).of_type(:float) }
    end
  end

  it 'has a valid factory' do
    expect(build(:post)).to be_valid
  end
end
