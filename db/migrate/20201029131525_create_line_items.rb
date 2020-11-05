class CreateLineItems < ActiveRecord::Migration[6.0]
  def change
    create_table :line_items do |t|
      t.string :content
      t.integer :note_id

      t.timestamps
    end
  end
end
