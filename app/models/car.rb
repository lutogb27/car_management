class Car < ApplicationRecord
  has_many :reservations
  belongs_to :user,optional: true

  validates :car_name, presence: true
end
