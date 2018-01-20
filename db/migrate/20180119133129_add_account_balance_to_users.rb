class AddAccountBalanceToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :account_balance, :decimal, precision: 8, scale: 2
    User.update_all(account_balance: 0.00)
  end
end
