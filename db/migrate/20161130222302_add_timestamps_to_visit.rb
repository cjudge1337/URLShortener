class AddTimestampsToVisit < ActiveRecord::Migration
  def change
    change_table(:visits) { |t| t.timestamps }
  end
end
