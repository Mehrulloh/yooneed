# spec/controllers/supervisor/orders_controller_spec.rb
require 'rails_helper'

RSpec.describe Supervisor::OrdersController, type: :controller do
  describe 'GET #index' do
    context 'when authenticated as supervisor' do
      let(:supervisor_user) { FactoryBot.create(:user, role: :supervisor) }

      before do
        sign_in supervisor_user
      end

      it 'assigns @orders' do
        order1 = FactoryBot.create(:order, status: :processing)
        order2 = FactoryBot.create(:order, status: :processing)

        get :index
        expect(assigns(:orders)).to match_array([order1, order2])
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context 'when not authenticated as supervisor' do
      it 'redirects to sign in page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
