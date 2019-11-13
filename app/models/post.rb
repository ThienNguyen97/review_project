class Post < ApplicationRecord
  scope :order_desc, ->{order created_at: :desc}
  has_many :reactions, dependent: :destroy
  has_many :post_images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :commented_users, through: :comments, source: :user
  belongs_to :user
  belongs_to :place

  accepts_nested_attributes_for :post_images, allow_destroy: true,
    reject_if: proc{|attributes| attributes["image"].blank?}

  scope :create_desc, ->{order created_at: :desc}
  scope :popular_posts, ->{order(status: :desc).take Settings.popular_posts}
  scope :user_posts, ->(id){where(user_id: id)}

  validates :user_id, presence: true
  validates :place_id, presence: true
  validates :title, presence: true
  validates :content, presence: true

  delegate :name, to: :place, prefix: :place, allow_nil: true
  delegate :address, to: :place, prefix: :place, allow_nil: true
  delegate :name, to: :user, prefix: :user

  POST_PARAMS = [:title, :content, :place_id,
  post_images_attributes: [:id, :post_id, :image]].freeze

  def num_of_likes
    reactions.where("reaction_type_id = ?", Settings.reaction_type.like).count
  end

  def num_of_comments
    comments.count
  end

end
