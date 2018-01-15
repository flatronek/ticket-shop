class Event < ApplicationRecord
  has_many :tickets

  validates :artist, presence: true, length: {in: 3..30}
  validates :price_low, presence: true
  validates :price_high, presence: true
  validates :event_date, presence: true
end
