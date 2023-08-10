class CreateTweet < ActiveRecord::Migration[7.0]
  def change
    create_table :tweets do |t|
      t.string :message
      t.integer :likes
      t.integer :user_id
      t.timestamps
    end
  end
end
