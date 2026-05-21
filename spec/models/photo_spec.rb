require "rails_helper"

RSpec.describe Photo, type: :model do
  subject(:photo) do
    Photo.new(
      photographer: "Ansel Adams",
      src_medium: "https://example.com/photo.jpg",
      source_url: "https://pexels.com/photo/123"
    )
  end

  describe "validations" do
    it { is_expected.to be_valid }

    it "requires photographer" do
      photo.photographer = nil
      expect(photo).not_to be_valid
    end

    it "requires src_medium" do
      photo.src_medium = nil
      expect(photo).not_to be_valid
    end

    it "requires source_url" do
      photo.source_url = nil
      expect(photo).not_to be_valid
    end
  end

  describe "defaults" do
    it "starts with likes_count of 0" do
      photo.save!
      expect(photo.likes_count).to eq(0)
    end
  end

  describe "associations" do
    it { is_expected.to respond_to(:likes) }
    it { is_expected.to respond_to(:liking_users) }
  end
end
