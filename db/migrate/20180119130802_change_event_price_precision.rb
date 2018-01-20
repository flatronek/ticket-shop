class ChangeEventPricePrecision < ActiveRecord::Migration[5.1]
  def change
    change_column :events, :price_low, :decimal, precision: 8, scale: 2
    change_column :events, :price_high, :decimal, precision: 8, scale: 2
  end
end
