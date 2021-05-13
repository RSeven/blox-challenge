require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user) { User.create(name: "test_user", password: "test_pass") }
  let(:classroom) { Classroom.create(name: "test classroom") }

  subject {
    described_class.new(title: "test event title",
                        start_time: Time.now,
                        end_time: Time.now + 1.hour,
                        user: user,
                        classroom: classroom
                      )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a start_time" do
    subject.start_time = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an end_time" do
    subject.end_time = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a user" do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a classroom" do
    subject.classroom = nil
    expect(subject).to_not be_valid
  end

end
