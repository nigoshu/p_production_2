class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.integer :tweet_id
      t.string :twitter_name
      t.string :twitter_screen_name
      t.integer :share_retcount

      t.timestamps
    end
  end
end
