require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    described_class.new(email: "user@test.com",
                        password: "test_pass",
                        password_confirmation: "test_pass")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without an email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a password" do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with a different password_confirmation" do
    subject.password_confirmation = "wrong_pass"
    expect(subject).to_not be_valid
  end

  it "is not valid with a duplicate email" do
    User.create!(email: subject.email,
                  password: subject.password)
    expect(subject).to_not be_valid
  end
end
