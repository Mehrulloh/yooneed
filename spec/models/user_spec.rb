require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'Factory' do
    it 'has a valid factory' do
      expect(build(:user)).to be_valid
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe 'name methods' do
    it 'returns a string for name' do
      expect(user.name).to be_instance_of(String)
    end

    it 'returns a string for surname' do
      expect(user.surname).to be_instance_of(String)
    end
  end

  describe 'role' do
    it 'assigns default role after creating user' do
      expect(user.role).to eq('supervisor')
    end

    it 'assigns supervisor role' do
      supervisor_user = create(:user, :role_supervisor)
      expect(supervisor_user.role).to eq('supervisor')
    end
  end
end
