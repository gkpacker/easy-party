class Event < ApplicationRecord
  belongs_to :organizer, foreign_key: "organizer_id", class_name: "User"
  has_many :jobs, dependency: :destroy
  has_many :pictures
  accepts_nested_attributes_for :pictures, \
  :reject_if => proc {|attributes| attributes['filename'].blank? \
  && attributes['filename_cache'].blank?}

  validates :date, :location, :title, presence: true
end
