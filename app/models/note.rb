class Note < ApplicationRecord
    belongs_to :user
    has_many :line_items
    has_many :note_tags, :dependent => :destroy
end
