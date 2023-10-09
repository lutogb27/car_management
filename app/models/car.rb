class Car < ApplicationRecord
  has_many :reservations
  belongs_to :user,optional: true

  validates :car_name, :introduction, :address, presence: true
end
