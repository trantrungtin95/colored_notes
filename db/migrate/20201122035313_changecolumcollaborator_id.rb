class ChangecolumcollaboratorId < ActiveRecord::Migration[6.0]
  def change
    rename_column :note_collaborators, :collaborator_id, :user_id
  end
end
