class AddAdultsOnlyToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :adults_only, :boolean, :default => false
    Event.update_all(adults_only: false)
  end
end
