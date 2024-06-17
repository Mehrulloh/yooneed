# spec/controllers/main_controller_spec.rb

require 'rails_helper'

RSpec.describe MainController, type: :controller do
  describe "GET #dashboard" do
    context "when user is authenticated" do
      let(:user) { FactoryBot.create(:user) }

      before do
        sign_in user # Assuming you have a method to sign in a user in your test setup
        get :dashboard
      end

      it "loads products into @products" do
        expect(assigns(:products)).to eq(Product.all.decorate)
      end

      it "loads completed orders into @completed" do
        expect(assigns(:completed)).to eq(Order.completed.decorate)
      end

      it "loads uncompleted orders into @uncompleted" do
        expect(assigns(:uncompleted)).to eq(Order.uncompleted.decorate)
      end

      it "renders the dashboard template" do
        expect(response).to render_template(:dashboard)
      end
    end

    context "when user is not authenticated" do
      it "redirects to sign in page" do
        get :dashboard
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
