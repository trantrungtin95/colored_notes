class AddReminderToNotes < ActiveRecord::Migration[6.0]
  def change
    add_column :notes, :reminder, :datetime
  end
end
