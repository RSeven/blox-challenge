class Event < ApplicationRecord
  belongs_to :user
  belongs_to :classroom

  validates_presence_of :title, :start_time, :end_time
end
