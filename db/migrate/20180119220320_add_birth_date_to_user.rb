class AddBirthDateToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :birth_date, :date
    User.update_all(birth_date: (Date.today - 20.years))
  end
end
