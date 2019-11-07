class City < ApplicationRecord
  has_many :travel
  validates :name, presence: true

  scope :order_by_name, ->(_name){order :name}
  scope :search_by_name, ->(name){where "name like ?", name}
end
