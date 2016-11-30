class CreateTimestamp < ActiveRecord::Migration
  def change_table
    add_column(:visits, :created_at, :datetime)
    add_column(:visits, :updated_at, :datetime)
  end
end
