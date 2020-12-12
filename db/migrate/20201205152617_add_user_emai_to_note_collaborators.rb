class AddUserEmaiToNoteCollaborators < ActiveRecord::Migration[6.0]
  def change
    add_column :note_collaborators, :user_email, :string
  end
end
