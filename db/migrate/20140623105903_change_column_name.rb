class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :user_locations, :location_app_session_id, :device_id
  end
end
