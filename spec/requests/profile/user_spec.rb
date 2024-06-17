require 'rails_helper'

RSpec.describe Profile::UserController, type: :controller do
  let(:user) { create(:user) }  # Assuming you have a User factory set up

  before do
    sign_in user  # Assuming you have a sign_in helper method for authentication
  end

  describe "PATCH #update" do
    context "with valid params" do
      let(:valid_params) do
        {
          user: {
            name: "New Name",
            surname: "New Surname",
            email: "new_email@example.com",
            password: "newpassword",
            password_confirmation: "newpassword"
          }
        }
      end

      it "updates the user profile" do
        patch :update, params: valid_params.merge(id: user.id)
        user.reload
        expect(user.name).to eq("New Name")
        expect(user.surname).to eq("New Surname")
        expect(user.email).to eq("new_email@example.com")
      end

      it "redirects to root path after update" do
        patch :update, params: valid_params.merge(id: user.id)
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      let(:invalid_params) do
        {
          user: {
            name: "",
            surname: "New Surname",
            email: "invalid_email",
            password: "short",
            password_confirmation: "password"
          }
        }
      end

      it "does not update the user profile" do
        patch :update, params: invalid_params.merge(id: user.id)
        user.reload
        expect(user.surname).not_to eq("New Surname")
        expect(user.email).not_to eq("invalid_email")
      end

      it "redirects back with unprocessable_entity status" do
        patch :update, params: invalid_params.merge(id: user.id)
        expect(response).to have_http_status(422)
      end
    end
  end
end
