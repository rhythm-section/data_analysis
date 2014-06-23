class CreateSystemSettings < ActiveRecord::Migration
  def change
    create_table :system_settings do |t|
      t.string :settings_timestamp
      t.integer :settings_airplane_mode
      t.integer :settings_bluetooth
      t.integer :settings_data_roaming
      t.integer :settings_development_settings_enabled
      t.string :settings_http_proxy
      t.string :settings_mode_ringer
      t.string :settings_volume_alarm
      t.string :settings_volume_music
      t.string :settings_volume_notification
      t.string :settings_volume_ring
      t.string :settings_volume_system
      t.string :settings_volume_voice
      t.string :settings_network_preference
      t.string :settings_stay_on_while_plugged_in
      t.integer :settings_usb_mass_storage_enabled
      t.integer :settings_wifi
      t.string :settings_wifi_ssid
      t.string :settings_location_mode_3
      t.integer :settings_location_mode_17
      t.integer :device_id

      t.timestamps
    end
  end
end
