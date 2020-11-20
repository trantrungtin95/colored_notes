class Tag < ApplicationRecord
    belongs_to :user
    has_many :note_tags, :dependent => :destroy
end
