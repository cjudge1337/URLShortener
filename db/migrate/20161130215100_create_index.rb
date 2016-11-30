class CreateIndex < ActiveRecord::Migration
  def change
    add_index :visits, :user_id
    add_index :visits, :shortened_id
  end
end
