require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { create(:order) }

  # describe 'Factory' do
  #   it 'has a valid factory' do
  #     expect(build(:order)).to be_valid
  #   end
  # end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:product_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:product) }
  end

  describe 'scopes' do
    describe 'processing scope' do
      let!(:processing_order) { create(:order, status: :processing) }
      let!(:accepted_order) { create(:order, status: :accepted) }

      it 'includes orders with processing status' do
        expect(Order.processing).to include(processing_order)
      end

      it 'excludes orders with accepted status' do
        expect(Order.processing).not_to include(accepted_order)
      end
    end

    describe 'accepted scope' do
      let!(:processing_order) { create(:order, status: :processing) }
      let!(:accepted_order) { create(:order, status: :accepted) }

      it 'includes orders with accepted status' do
        expect(Order.accepted).to include(accepted_order)
      end

      it 'excludes orders with processing status' do
        expect(Order.accepted).not_to include(processing_order)
      end
    end

    describe 'denied scope' do
      let!(:processing_order) { create(:order, status: :processing) }
      let!(:denied_order) { create(:order, status: :denied) }

      it 'includes orders with denied status' do
        expect(Order.denied).to include(denied_order)
      end

      it 'excludes orders with processing status' do
        expect(Order.denied).not_to include(processing_order)
      end
    end

    describe 'completed scope' do
      let!(:processing_order) { create(:order, status: :processing) }
      let!(:accepted_order) { create(:order, status: :accepted) }
      let!(:denied_order) { create(:order, status: :denied) }

      it 'includes orders with accepted or denied status' do
        expect(Order.completed).to include(accepted_order, denied_order)
      end

      it 'excludes orders with processing status' do
        expect(Order.completed).not_to include(processing_order)
      end
    end

    describe 'uncompleted scope' do
      let!(:processing_order) { create(:order, status: :processing) }
      let!(:accepted_order) { create(:order, status: :accepted) }
      let!(:denied_order) { create(:order, status: :denied) }

      it 'includes orders with processing status' do
        expect(Order.uncompleted).to include(processing_order)
      end

      it 'excludes orders with accepted or denied status' do
        expect(Order.uncompleted).not_to include(accepted_order, denied_order)
      end
    end
  end
end
