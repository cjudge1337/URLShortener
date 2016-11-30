class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :link_id, null:false
      t.integer :topic_id, null: false
    end

    add_index :taggings, :link_id
    add_index :taggings, :topic_id
  end
end
