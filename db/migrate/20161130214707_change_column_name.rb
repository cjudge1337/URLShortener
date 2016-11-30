class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :visits, :short_url, :shortened_id
  end
end
