class Place < ApplicationRecord
  # ratyrate_rateable "quality"
  resourcify

  belongs_to :city
  has_many :place_images, dependent: :destroy

  scope :order_by_name, ->(_name){order :name}
  scope :popular_places, ->{order(rate_point: :desc).take Settings.popular_places}

  scope :get_places, ->(name, address){where(name: name) | where(address: address)}
  scope :search_by_name, ->(name){where "name like ?", name}
  # scope :get_type, ->(type){where "type_travel_place_id = ?", type}


  validates :name, presence: true
  validates :city_id, presence: true
  delegate :name, to: :city, prefix: :city, allow_nil: true
end
