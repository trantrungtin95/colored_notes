class NoteCollaborator < ApplicationRecord
    belongs_to :note
    belongs_to :user
end
