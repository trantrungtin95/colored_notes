class CreateNoteCollaborators < ActiveRecord::Migration[6.0]
  def change
    create_table :note_collaborators do |t|
      t.integer :note_id
      t.integer :collaborator_id

      t.timestamps
    end
  end
end
