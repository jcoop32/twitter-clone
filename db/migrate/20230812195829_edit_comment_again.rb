class EditCommentAgain < ActiveRecord::Migration[7.0]
  def change
    remove_column :comments, :post_id, :integer
    add_column :comments, :tweet_id, :integer
  end
end
