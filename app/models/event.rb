class Event < ApplicationRecord
  belongs_to :organizer, foreign_key: "organizer_id", class_name: "User"
  has_many :jobs, dependent: :destroy
  has_many :pictures, dependent: :destroy
  accepts_nested_attributes_for :pictures, allow_destroy: true, \
  :reject_if => proc {|attributes| attributes['filename'].blank? \
  && attributes['filename_cache'].blank?}

  validates :date, :location, :title, presence: true

  def to_param
    "#{id}-#{title.parameterize}"
  end
end
