require "rails_helper"

RSpec.describe "Likes", type: :request do
  let(:user)  { User.create!(email: "alice@example.com", password: "password") }
  let(:other) { User.create!(email: "bob@example.com",   password: "password") }
  let(:photo) { Photo.create!(photographer: "Ansel Adams", src_medium: "https://example.com/photo.jpg", source_url: "https://pexels.com/photo/1") }

  describe "authentication guard" do
    it "redirects unauthenticated create to sign-in" do
      post photo_likes_path(photo)
      expect(response).to redirect_to(new_session_path)
    end

    it "redirects unauthenticated destroy to sign-in" do
      like = photo.likes.create!(user: user)
      delete photo_like_path(photo, like)
      expect(response).to redirect_to(new_session_path)
    end
  end

  describe "POST /photos/:photo_id/likes" do
    before { sign_in(user, password: "password") }

    it "creates a like" do
      expect {
        post photo_likes_path(photo), headers: { "Accept" => "text/vnd.turbo-stream.html" }
      }.to change { photo.likes.count }.by(1)
    end

    it "responds with Turbo Stream" do
      post photo_likes_path(photo), headers: { "Accept" => "text/vnd.turbo-stream.html" }
      expect(response.media_type).to eq("text/vnd.turbo-stream.html")
    end

    it "is idempotent — duplicate like does not error" do
      photo.likes.create!(user: user)
      expect {
        post photo_likes_path(photo), headers: { "Accept" => "text/vnd.turbo-stream.html" }
      }.not_to change { photo.likes.count }
      expect(response).to be_successful
    end

    it "falls back to redirect without Turbo Stream header" do
      post photo_likes_path(photo)
      expect(response).to redirect_to(photos_path)
    end
  end

  describe "DELETE /photos/:photo_id/likes/:id" do
    before { sign_in(user, password: "password") }

    let!(:like) { photo.likes.create!(user: user) }

    it "destroys the like" do
      expect {
        delete photo_like_path(photo, like), headers: { "Accept" => "text/vnd.turbo-stream.html" }
      }.to change { photo.likes.count }.by(-1)
    end

    it "responds with Turbo Stream" do
      delete photo_like_path(photo, like), headers: { "Accept" => "text/vnd.turbo-stream.html" }
      expect(response.media_type).to eq("text/vnd.turbo-stream.html")
    end

    it "cannot destroy another user's like" do
      other_like = photo.likes.create!(user: other)
      expect {
        delete photo_like_path(photo, other_like), headers: { "Accept" => "text/vnd.turbo-stream.html" }
      }.not_to change { photo.likes.count }
    end

    it "falls back to redirect without Turbo Stream header" do
      delete photo_like_path(photo, like)
      expect(response).to redirect_to(photos_path)
    end
  end
end
