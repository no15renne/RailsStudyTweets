class RenameColumnToTweets < ActiveRecord::Migration
  def change
    rename_column :tweets, :conent, :content
  end
end
