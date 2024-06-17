# spec/controllers/orders_controller_spec.rb

require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:product) { FactoryBot.create(:product) }
  let(:order) { FactoryBot.create(:order, product: product, user: user) }

  before do
    sign_in user
  end

  describe "GET #new" do
    it "assigns a new order as @order" do
      get :new, params: { product_id: product.id }
      expect(assigns(:order)).to be_a_new(Order)
    end

    it "renders the new template" do
      get :new, params: { product_id: product.id }
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_attributes) { FactoryBot.attributes_for(:order, product_id: product.id) }

      it "creates a new order" do
        expect {
          post :create, params: { order: valid_attributes }
        }.to change(Order, :count).by(1)
      end

      it "redirects to root path with success notice" do
        post :create, params: { order: valid_attributes }
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq("Your order has been processed successfully.")
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { FactoryBot.attributes_for(:order, product_id: nil) }

      it "does not create a new order" do
        expect {
          post :create, params: { order: invalid_attributes }
        }.not_to change(Order, :count)
      end

      it "redirects back with alert on failure to process the order" do
        post :create, params: { order: invalid_attributes }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("Failed to process the order.")
      end
    end
  end

  describe "PATCH #accept" do
    it "updates the order status to accepted" do
      patch :accept, params: { id: order.id }
      order.reload
      expect(order.status).to eq("accepted")
    end

    it "redirects back with success notice on successful acceptance" do
      patch :accept, params: { id: order.id }
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq("Order successfully accepted.")
    end

    it "redirects back with alert on failure to update order status" do
      order = FactoryBot.create(:order) # Create a new order instance or mock it as needed
      allow(Order).to receive(:find).with(order.id.to_s).and_return(order)
      allow(order).to receive(:accepted!).and_return(false)

      patch :accept, params: { id: order.id }

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq("Failed to update order status.")
    end
  end

  describe "PATCH #deny" do
    it "updates the order status to denied" do
      patch :deny, params: { id: order.id }
      order.reload
      expect(order.status).to eq("denied")
    end

    it "redirects back with success notice on successful denial" do
      patch :deny, params: { id: order.id }
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq("Order denied successfully.")
    end

    it "redirects back with alert on failure to deny order" do
      order = FactoryBot.create(:order) # Create a new order instance or mock it as needed
      allow(Order).to receive(:find).with(order.id.to_s).and_return(order)
      allow(order).to receive(:denied!).and_return(false)

      patch :deny, params: { id: order.id }

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq("Failed to deny order.")
    end
  end
end
