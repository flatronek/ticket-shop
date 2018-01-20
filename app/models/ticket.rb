class Ticket < ApplicationRecord
  belongs_to :event
  belongs_to :user

  attr_accessor :omit_validation

  validates :name, presence: true, length: {minimum: 5}
  validates :email, presence: true
  validates :price, presence: true
  validates :address, presence: true, length: {in: 5..30}
  validates :seat_id, presence: true, numericality: {only_integer: true}

  validate :enough_account_funds, :not_too_many_tickets_bought, :user_old_enough, unless: :omit_validation

  def user_old_enough
    if user.birth_date > (Date.today - 18.years)
      errors.add('You', ' must be over 18 years old.')
    end
  end

  def enough_account_funds
    if user.account_balance < price
      errors.add('Funds: ', 'You do not have enough funds on your account.')
    end
  end

  def not_too_many_tickets_bought
    if user.tickets.select {|ticket| ticket.event_id == event_id}.length >= 5
      errors.add('Ticket amount: ', 'You cant buy more tickets for that event.')
    end
  end
end
