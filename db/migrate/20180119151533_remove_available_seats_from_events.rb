class RemoveAvailableSeatsFromEvents < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :available_seats
  end
end
