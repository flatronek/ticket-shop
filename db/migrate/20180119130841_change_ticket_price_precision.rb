class ChangeTicketPricePrecision < ActiveRecord::Migration[5.1]
  def change
    change_column :tickets, :price, :decimal, precision: 8, scale: 2
  end
end
