require 'rails_helper'

RSpec.describe Classroom, type: :model do
  subject {
    described_class.new(name: "test classroom")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with a duplicate name" do
    Classroom.create!(name: subject.name)
    expect(subject).to_not be_valid
  end
end
