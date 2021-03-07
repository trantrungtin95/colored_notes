class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.integer :user_id
      t.string :tag_name

      t.timestamps
    end
  end
end
