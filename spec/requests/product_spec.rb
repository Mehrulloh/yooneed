require 'rails_helper'

RSpec.describe ProductsController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:product) { FactoryBot.create(:product) }

  before do
    login_as(user, scope: :user)
  end

  describe "GET #index" do
    it "renders the index template" do
      FactoryBot.create(:product) # Ensure there is at least one product
      get "/products"
      expect(response).to be_successful
      expect(response.body).to include("Produkten")
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new product and redirects with notice" do
        product_params = FactoryBot.attributes_for(:product)

        expect {
          post "/products", params: { product: product_params }
        }.to change(Product, :count).by(1)

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include("Product was successfully created.")
      end
    end

    context "with invalid parameters" do
      it "does not create a new product" do
        product_params = FactoryBot.attributes_for(:product, name: nil)

        expect {
          post products_path, params: { product: product_params }
        }.not_to change(Product, :count)

        expect(response).to have_http_status(422)  # Expecting unprocessable_entity (422)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      it "updates product attributes and redirects" do
        patch product_path(product), params: { product: { name: "Updated Product" } }

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include("Product was successfully updated.")
        product.reload
        expect(product.name).to eq("Updated Product")
      end
    end

    context "with invalid parameters" do
      it "returns unprocessable_entity status on invalid update" do
        patch product_path(product), params: { product: { name: nil } }, as: :json

        expect(response).to have_http_status(422)

        json_response = JSON.parse(response.body)
        expect(json_response).to include("name")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the product and redirects to index" do
      product_to_delete = FactoryBot.create(:product)

      expect {
        delete product_path(product_to_delete)
      }.to change(Product, :count).by(-1)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(products_path)
      follow_redirect!
      expect(response.body).to include("Product was successfully destroyed.")
    end
  end
end
