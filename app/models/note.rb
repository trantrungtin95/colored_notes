class Note < ApplicationRecord
    belongs_to :user
    has_many :line_items
    has_many_attached :images, :dependent => :destroy
    has_many :note_collaborators, :dependent => :destroy
    has_many :note_tags, :dependent => :destroy
    scope :find_title, -> (search) {where "title iLIKE ?", "%#{search}%"}
    
end