class Comment < ApplicationRecord
  belongs_to :tweet
  belongs_to :user
  validates :message, presence: true, length: {minimum: 1, maximum: 280}
end
