class Category < ApplicationRecord
  has_many :professionals, foreign_key: "category_id", class_name: "User"
  validates :name, uniqueness: true
end
