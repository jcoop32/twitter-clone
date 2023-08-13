class RemoveTweetLikes < ActiveRecord::Migration[7.0]
  def change
    remove_column :tweets, :likes, :integer
  end
end
