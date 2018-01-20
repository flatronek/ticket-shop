class AddReturnPendingToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :pending_return, :boolean, :default => false
    Ticket.update_all(:pending_return => false)
  end
end
