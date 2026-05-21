require "rails_helper"

RSpec.describe Like, type: :model do
  let(:user)  { User.create!(email: "liker@example.com", password: "password") }
  let(:photo) do
    Photo.create!(
      photographer: "Test Photographer",
      src_medium: "https://example.com/img.jpg",
      source_url: "https://pexels.com/photo/999"
    )
  end

  subject(:like) { Like.new(user: user, photo: photo) }

  describe "validations" do
    it { is_expected.to be_valid }

    it "prevents duplicate likes from same user on same photo" do
      like.save!
      duplicate = Like.new(user: user, photo: photo)
      expect(duplicate).not_to be_valid
    end

    it "allows same user to like different photos" do
      other_photo = Photo.create!(
        photographer: "Other",
        src_medium: "https://example.com/other.jpg",
        source_url: "https://pexels.com/photo/111"
      )
      like.save!
      other_like = Like.new(user: user, photo: other_photo)
      expect(other_like).to be_valid
    end

    it "allows different users to like same photo" do
      other_user = User.create!(email: "other@example.com", password: "password")
      like.save!
      other_like = Like.new(user: other_user, photo: photo)
      expect(other_like).to be_valid
    end
  end

  describe "database uniqueness constraint" do
    it "raises on duplicate at the database level" do
      like.save!
      expect {
        Like.create!(user: user, photo: photo)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
