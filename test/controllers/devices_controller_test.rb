require 'test_helper'

class DevicesControllerTest < ActionController::TestCase
  setup do
    @device = devices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:devices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create device" do
    assert_difference('Device.count') do
      post :create, device: { android_id: @device.android_id, app_sessions: @device.app_sessions, brand: @device.brand, created_at: @device.created_at, manufacturer: @device.manufacturer, model: @device.model, mongo_id: @device.mongo_id, os_version: @device.os_version, product: @device.product, user_activities: @device.user_activities, user_locations: @device.user_locations, user_name: @device.user_name, uuid: @device.uuid }
    end

    assert_redirected_to device_path(assigns(:device))
  end

  test "should show device" do
    get :show, id: @device
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @device
    assert_response :success
  end

  test "should update device" do
    patch :update, id: @device, device: { android_id: @device.android_id, app_sessions: @device.app_sessions, brand: @device.brand, created_at: @device.created_at, manufacturer: @device.manufacturer, model: @device.model, mongo_id: @device.mongo_id, os_version: @device.os_version, product: @device.product, user_activities: @device.user_activities, user_locations: @device.user_locations, user_name: @device.user_name, uuid: @device.uuid }
    assert_redirected_to device_path(assigns(:device))
  end

  test "should destroy device" do
    assert_difference('Device.count', -1) do
      delete :destroy, id: @device
    end

    assert_redirected_to devices_path
  end
end
