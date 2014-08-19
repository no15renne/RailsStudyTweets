class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :userid
      t.integer :followuserid

      t.timestamps
    end
  end
end
