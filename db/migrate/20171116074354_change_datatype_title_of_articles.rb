class ChangeDatatypeTitleOfArticles < ActiveRecord::Migration[5.1]
  def change
        change_column :tweets, :tweet_id, :string
  end
end
