require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user) { User.create(email: "user@test.com", password: "test_pass") }
  let(:classroom) { Classroom.create(name: "test classroom") }

  subject {
    described_class.new(title: "test event title",
                        start_time: Time.now + 1.hour,
                        end_time: Time.now + 2.hour,
                        user: user,
                        classroom: classroom)
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

  it "is not valid with a start_time in the past" do
    subject.start_time = Time.now - 1.hour
    expect(subject).to_not be_valid
  end

  it "is not valid with a end_time before start_time" do
    subject.end_time = subject.start_time - 1.hour
    expect(subject).to_not be_valid
  end

  it "is not valid if an event is already scheduled to the same classroom at the same time" do
    Event.create!(title: subject.title,
                  start_time: subject.start_time,
                  end_time: subject.end_time,
                  user: subject.user,
                  classroom: subject.classroom)
    expect(subject).to_not be_valid
  end

end
