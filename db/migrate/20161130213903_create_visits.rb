class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :user_id, null: false
      t.integer :short_url, null: false
      
      t.timestamp
    end
  end
end
