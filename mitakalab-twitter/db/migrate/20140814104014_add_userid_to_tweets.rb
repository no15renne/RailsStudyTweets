class AddUseridToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :userid, :integer
  end
end
