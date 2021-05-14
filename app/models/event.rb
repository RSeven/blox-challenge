class Event < ApplicationRecord
  belongs_to :user
  belongs_to :classroom

  validates_presence_of :title
  
  validates :start_time, date: { 
    after_or_equal_to: Proc.new { |obj| [Time.now, Time.beginning_of_workday(obj.start_time)].max },
    before: Proc.new { |obj| Time.end_of_workday(obj.start_time) }
  }

  validates :end_time, date: {
    after: :start_time,
    before_or_equal_to: Proc.new { |obj| Time.end_of_workday(obj.start_time || obj.end_time) }
  }

  validate :classroom_availability, if: Proc.new { will_save_change_to_classroom_id? || will_save_change_to_start_time? || will_save_change_to_end_time? }

private

  def classroom_availability
    if Event.exists?(["id <> ? AND classroom_id = ? AND end_time >= ? AND start_time < ?", id.to_i, classroom_id, start_time, end_time])
      errors.add :base, "The classroom is not available at the chosen time."
    end
  end
end
