require "rails_helper"

RSpec.describe User, type: :model do
  subject(:user) { User.new(email: "test@example.com", password: "secret123") }

  describe "validations" do
    it { is_expected.to be_valid }

    it "requires email" do
      user.email = nil
      expect(user).not_to be_valid
    end

    it "requires uniqueness of email" do
      user.save!
      duplicate = User.new(email: user.email, password: "other")
      expect(duplicate).not_to be_valid
    end

    it "treats email uniqueness case-insensitively" do
      user.save!
      duplicate = User.new(email: user.email.upcase, password: "other")
      expect(duplicate).not_to be_valid
    end

    it "requires password on create" do
      blank_password_user = User.new(email: "new@example.com", password: "")
      expect(blank_password_user).not_to be_valid
    end
  end

  describe "has_secure_password" do
    it "authenticates with correct password" do
      user.save!
      expect(user.authenticate("secret123")).to eq(user)
    end

    it "rejects incorrect password" do
      user.save!
      expect(user.authenticate("wrong")).to be(false)
    end
  end

  describe "associations" do
    it { is_expected.to respond_to(:likes) }
    it { is_expected.to respond_to(:liked_photos) }
  end
end
