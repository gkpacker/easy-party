class Event < ApplicationRecord
  belongs_to :organizer, foreign_key: "event_id", class_name: "User"
  has_many :jobs
  validates :date, :location, :title, presence: true
end
