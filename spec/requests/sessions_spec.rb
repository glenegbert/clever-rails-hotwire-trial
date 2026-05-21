require "rails_helper"

RSpec.describe "Sessions", type: :request do
  let(:user) { User.create!(email: "test@example.com", password: "password") }

  describe "GET /session/new" do
    it "returns 200" do
      get new_session_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /session" do
    context "with valid credentials" do
      it "redirects to root and sets session" do
        post session_path, params: { email: user.email, password: "password" }
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid credentials" do
      it "re-renders sign-in with 422" do
        post session_path, params: { email: user.email, password: "wrong" }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "DELETE /session" do
    it "clears session and redirects to sign-in" do
      sign_in(user, password: "password")
      delete session_path
      expect(response).to redirect_to(new_session_path)
    end
  end

  describe "authentication gate" do
    it "redirects unauthenticated requests to sign-in" do
      get root_path
      expect(response).to redirect_to(new_session_path)
    end

    it "allows authenticated requests through" do
      sign_in(user, password: "password")
      get root_path
      expect(response).not_to redirect_to(new_session_path)
    end
  end
end
