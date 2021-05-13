require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    described_class.new(name: "test_user",
                        password: "test_pass",
                        password_confirmation: "test_pass")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
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
end
