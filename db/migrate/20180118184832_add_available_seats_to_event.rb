class AddAvailableSeatsToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :available_seats, :integer
    Event.update_all('available_seats=total_seats')
  end
end
