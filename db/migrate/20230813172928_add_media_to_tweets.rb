class AddMediaToTweets < ActiveRecord::Migration[7.0]
  def change
    add_column :tweets, :image, :string
  end
end
