class PostImage < ApplicationRecord
  mount_uploader :link, ImageUploader
  belongs_to :post
  validates :post_id, presence: true
end
