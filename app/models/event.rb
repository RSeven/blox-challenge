class Event < ApplicationRecord
  belongs_to :user
  belongs_to :classroom

  validates_presence_of :title, :start_time, :end_time
  validates :start_time, after: :now, on: :create
  validates :end_time, after: :start_time
end
