require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { create(:product) }

  describe 'Factory' do
    it 'has a valid factory' do
      expect(build(:product)).to be_valid
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:packing_type) }
  end

  describe 'name methods' do
    it 'returns a string for name' do
      expect(product.name).to be_instance_of(String)
    end

    it 'returns a string for packing_type' do
      expect(product.packing_type).to be_instance_of(String)
    end
  end
end
