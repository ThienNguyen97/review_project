class Comment < ApplicationRecord
  scope :order_desc, ->{order created_at: :desc}
  belongs_to :user
  belongs_to :post
  scope :create_desc, ->{order(created_at: :desc)}
  scope :list_post_comments, ->(post_id){where post_id: post_id}

  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :content, presence: true, allow_blank: false

  def post_notificable_path
    posts_show_path id: post.id
  end
end
