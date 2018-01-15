class Ticket < ApplicationRecord
  belongs_to :event

  validates :name, presence: true, length: {minimum: 6}
  validates :email, presence: true
  validates :price, presence: true
  validates :address, presence: true, length: {in: 6..30}
  validates :seat_id, presence: true, length: {is: 3}
end
