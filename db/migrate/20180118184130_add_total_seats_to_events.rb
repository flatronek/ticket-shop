class AddTotalSeatsToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :total_seats, :integer
    Event.update_all(total_seats: 30)
  end
end
