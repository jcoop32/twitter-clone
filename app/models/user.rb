class User < ApplicationRecord
  before_save {self.email = email.downcase}

  validates :name, presence: true, length: {minimum: 1, maximum: 50}

  validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 25}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:true, uniqueness: {case_sensitive: false}, length: { maximum: 105}, format: {with: VALID_EMAIL_REGEX}

  has_secure_password

  has_many :tweets
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :comments
  has_many :likes


  def not_friends_with?(id)
    !self.friends.where(id: id).exists?
  end

  def liked_tweet?(tweet_id)
    self.likes.where(tweet_id: tweet_id).exists?
  end

end
