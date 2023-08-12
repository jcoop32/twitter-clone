class Tweet < ApplicationRecord
  after_initialize :set_default

  def set_default
    likes = 0
  end

  belongs_to :user
  has_many :comments

  validates :message, presence: true, length: {minimum: 1, maximum: 280}
end
