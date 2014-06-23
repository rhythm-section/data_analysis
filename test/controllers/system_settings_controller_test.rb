require 'test_helper'

class SystemSettingsControllerTest < ActionController::TestCase
  setup do
    @system_setting = system_settings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:system_settings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create system_setting" do
    assert_difference('SystemSetting.count') do
      post :create, system_setting: { device_id: @system_setting.device_id, settings_airplane_mode: @system_setting.settings_airplane_mode, settings_bluetooth: @system_setting.settings_bluetooth, settings_data_roaming: @system_setting.settings_data_roaming, settings_development_settings_enabled: @system_setting.settings_development_settings_enabled, settings_http_proxy: @system_setting.settings_http_proxy, settings_location_mode_17: @system_setting.settings_location_mode_17, settings_location_mode_3: @system_setting.settings_location_mode_3, settings_mode_ringer: @system_setting.settings_mode_ringer, settings_network_preference: @system_setting.settings_network_preference, settings_stay_on_while_plugged_in: @system_setting.settings_stay_on_while_plugged_in, settings_timestamp: @system_setting.settings_timestamp, settings_usb_mass_storage_enabled: @system_setting.settings_usb_mass_storage_enabled, settings_volume_alarm: @system_setting.settings_volume_alarm, settings_volume_music: @system_setting.settings_volume_music, settings_volume_notification: @system_setting.settings_volume_notification, settings_volume_ring: @system_setting.settings_volume_ring, settings_volume_system: @system_setting.settings_volume_system, settings_volume_voice: @system_setting.settings_volume_voice, settings_wifi: @system_setting.settings_wifi, settings_wifi_ssid: @system_setting.settings_wifi_ssid }
    end

    assert_redirected_to system_setting_path(assigns(:system_setting))
  end

  test "should show system_setting" do
    get :show, id: @system_setting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @system_setting
    assert_response :success
  end

  test "should update system_setting" do
    patch :update, id: @system_setting, system_setting: { device_id: @system_setting.device_id, settings_airplane_mode: @system_setting.settings_airplane_mode, settings_bluetooth: @system_setting.settings_bluetooth, settings_data_roaming: @system_setting.settings_data_roaming, settings_development_settings_enabled: @system_setting.settings_development_settings_enabled, settings_http_proxy: @system_setting.settings_http_proxy, settings_location_mode_17: @system_setting.settings_location_mode_17, settings_location_mode_3: @system_setting.settings_location_mode_3, settings_mode_ringer: @system_setting.settings_mode_ringer, settings_network_preference: @system_setting.settings_network_preference, settings_stay_on_while_plugged_in: @system_setting.settings_stay_on_while_plugged_in, settings_timestamp: @system_setting.settings_timestamp, settings_usb_mass_storage_enabled: @system_setting.settings_usb_mass_storage_enabled, settings_volume_alarm: @system_setting.settings_volume_alarm, settings_volume_music: @system_setting.settings_volume_music, settings_volume_notification: @system_setting.settings_volume_notification, settings_volume_ring: @system_setting.settings_volume_ring, settings_volume_system: @system_setting.settings_volume_system, settings_volume_voice: @system_setting.settings_volume_voice, settings_wifi: @system_setting.settings_wifi, settings_wifi_ssid: @system_setting.settings_wifi_ssid }
    assert_redirected_to system_setting_path(assigns(:system_setting))
  end

  test "should destroy system_setting" do
    assert_difference('SystemSetting.count', -1) do
      delete :destroy, id: @system_setting
    end

    assert_redirected_to system_settings_path
  end
end
