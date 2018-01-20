class Event < ApplicationRecord
  has_many :tickets, dependent: :destroy

  validate :seats_greater_than_tickets

  validates :artist, presence: true, length: {in: 3..30}
  validates :price_low, presence: true, numericality: {only_float: true, :greater_than => 0}
  validates :price_high, presence: true, numericality: {only_float: true, :greater_than => 0}
  validates :event_date, presence: true
  validates :total_seats, presence: true, numericality: {only_integer: true, :greater_than => 0}

  validate :event_date_not_from_past, :max_price_higher_than_lowest

  def event_date_not_from_past
    if event_date < Date.today
      errors.add('Event date', 'cannot be from past.')
    end
  end

  def max_price_higher_than_lowest
    if price_low > price_high
      errors.add('Lowest price', 'must be lower than highest price.')
    end
  end

  def seats_greater_than_tickets
    if total_seats < tickets.length
      errors.add('Total seats', 'cannot be lower than the sold tickets amount.')
    end
  end
end
