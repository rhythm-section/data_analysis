class AddSettingsAppSessionIdToSystemSettings < ActiveRecord::Migration
  def change
    add_column :system_settings, :settings_app_session_id, :integer
  end
end
