class Event < ApplicationRecord
  belongs_to :user
  belongs_to :classroom

  validates_presence_of :title, :start_time, :end_time
  validates :start_time, after: :now, on: :create
  validates :end_time, after: :start_time
  validate :classroom_availability

private

  def classroom_availability
    if Event.exists?(["id <> ? AND classroom_id = ? AND end_time >= ? and start_time < ?", id.to_i, classroom_id, start_time, end_time])
      errors.add :base, "The classroom is not available at the chosen time."
    end
  end
end
