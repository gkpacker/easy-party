class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :events, foreign_key: "organizer_id"
  has_many :jobs, foreign_key: "professional_id"
  belongs_to :category
  validates :first_name, :last_name, presence: true
  validates :role, presence: true, inclusion: { in: ["Professional", "Organizer"] }
  validates :phone_number, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
