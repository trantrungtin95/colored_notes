class AddColorToNotes < ActiveRecord::Migration[6.0]
  def change
    add_column :notes, :color, :string, :default => "#ebecf0"
    #Ex:- :default =>''
  end
end
