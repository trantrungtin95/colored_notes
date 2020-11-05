class AddPinToNotes < ActiveRecord::Migration[6.0]
  def change
    add_column :notes, :pin, :string, :default => "off"
    #Ex:- :default =>''
  end
end
