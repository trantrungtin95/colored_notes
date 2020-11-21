class LineItem < ApplicationRecord
    belongs_to :note
    scope :find_content, -> (search) {where "content iLIKE ?", "%#{search}%"}

end
