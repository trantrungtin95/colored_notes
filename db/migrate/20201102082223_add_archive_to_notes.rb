class AddArchiveToNotes < ActiveRecord::Migration[6.0]
  def change
    add_column :notes, :archive, :string, :default => "off"
    #Ex:- :default =>''
  end
end
