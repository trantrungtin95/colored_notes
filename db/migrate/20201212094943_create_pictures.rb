class CreatePictures < ActiveRecord::Migration[6.0]
  def change
    create_table :pictures do |t|
      t.integer :note_id
      t.string :image_url

      t.timestamps
    end
  end
end
