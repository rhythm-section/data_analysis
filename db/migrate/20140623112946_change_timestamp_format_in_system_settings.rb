class ChangeTimestampFormatInSystemSettings < ActiveRecord::Migration
  def change
    change_column :system_settings, :settings_timestamp, :datetime
  end
end
