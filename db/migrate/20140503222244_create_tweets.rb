class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :site_id
      t.integer :result_size
      t.integer :retweets
      t.integer :favs

      t.timestamps
    end
  end
end
