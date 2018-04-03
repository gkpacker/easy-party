class Job < ApplicationRecord
  belongs_to :event
  belongs_to :professional, foreign_key: "professional_id", class_name: "User"
  validates :price, presence: true
end
