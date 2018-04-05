class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :photo, PhotoUploader

  has_many :events, foreign_key: "organizer_id"
  has_many :jobs, foreign_key: "professional_id"
  has_many :ratings, foreign_key: "professional_id"
  has_many :ratings, foreign_key: "organizer_id"
  belongs_to :category, optional: true

  validates :city, presence: :true, if: :professional?, on: :update
  validates :availability, presence: :true, if: :professional?, on: :update
  validates :price_per_hour, presence: :true, if: :professional?, on: :update
  validates :category_id, presence: :true, if: :professional?, on: :update
  validates :first_name, :last_name, presence: true
  validates :role, presence: true, inclusion: { in: ["Profissional", "Organizador"] }
  validates :phone_number, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include PgSearch
  pg_search_scope :search,
    against: [ :city, :first_name, :last_name ],
    associated_against: {
      category: [ :name ]
    },
    using: {
      tsearch: { prefix: true }
    }

  # pg_search_scope :order_query,
  #   against: [ :city, :first_name, :last_name ],
  #   associated_against: {
  #     category: [ :name ]
  #   },
  #   using: {
  #     tsearch: { prefix: true }
  #   }

  def professional?
    role == "Profissional"
  end

  def to_param
    "#{id}-#{full_name.parameterize}"
  end

  def full_name
    first_name + " " + last_name
  end
end
