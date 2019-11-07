class PlaceImage < ApplicationRecord
  belongs_to :place

  validates :place_id, presence: true
end
