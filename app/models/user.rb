class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :reactions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
                                  foreign_key: :follower_id,
                                  dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
                                   foreign_key: :followed_id,
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  attr_accessor :activation_token
  before_save :downcase_email

  validates :name, presence: true,
  length: {maximum: Settings.user.validates.max_name_length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
  length: {maximum: Settings.user.validates.max_email_length},
  format: {with: VALID_EMAIL_REGEX},
  uniqueness: {case_sensitive: false}
  validates :password, presence: true, allow_nil: true,
  length: {minimum: Settings.user.validates.min_pass_length}

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end


  def activate
    update_attributes activated: true, activated_at: Time.zone.now
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  private

  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
