class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :vote_value, null: false
      t.integer :user_id, null: false
      t.integer :link_id, null: false

      t.timestamps
    end
  end
end
