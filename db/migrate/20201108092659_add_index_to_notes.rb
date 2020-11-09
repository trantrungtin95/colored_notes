class AddIndexToNotes < ActiveRecord::Migration[6.0]
  def change
    add_column :notes, :index, :integer
  end
end
