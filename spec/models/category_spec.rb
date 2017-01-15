require 'rails_helper'

RSpec.describe Category, type: :model do

  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  context 'db' do
    context 'indexes' do
      it { is_expected.to have_db_index(:name) }
    end

    context 'columns' do
      it { is_expected.to have_db_column(:name).of_type(:string) }
    end
  end

  it 'has a valid factory' do
    expect(build(:category)).to be_valid
  end

  describe '#name' do
    it 'stores name in downcase and removes whitespace' do
      user = create(:category, name: 'Com p u t in   g')
      expect(user.name).to eq 'Computing'
    end
  end
end
