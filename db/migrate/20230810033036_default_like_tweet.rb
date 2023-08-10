class DefaultLikeTweet < ActiveRecord::Migration[7.0]
  def change
    change_column :tweets, :likes, :integer, default: 0
  end
end
