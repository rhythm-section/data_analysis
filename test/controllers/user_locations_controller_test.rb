require 'test_helper'

class UserLocationsControllerTest < ActionController::TestCase
  setup do
    @user_location = user_locations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_location" do
    assert_difference('UserLocation.count') do
      post :create, user_location: { location_accuracy: @user_location.location_accuracy, location_altitude: @user_location.location_altitude, location_app_session_id: @user_location.location_app_session_id, location_elapsed_realtime_nanos: @user_location.location_elapsed_realtime_nanos, location_latitude: @user_location.location_latitude, location_longitude: @user_location.location_longitude, location_provider: @user_location.location_provider, location_speed: @user_location.location_speed, location_timestamp: @user_location.location_timestamp }
    end

    assert_redirected_to user_location_path(assigns(:user_location))
  end

  test "should show user_location" do
    get :show, id: @user_location
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_location
    assert_response :success
  end

  test "should update user_location" do
    patch :update, id: @user_location, user_location: { location_accuracy: @user_location.location_accuracy, location_altitude: @user_location.location_altitude, location_app_session_id: @user_location.location_app_session_id, location_elapsed_realtime_nanos: @user_location.location_elapsed_realtime_nanos, location_latitude: @user_location.location_latitude, location_longitude: @user_location.location_longitude, location_provider: @user_location.location_provider, location_speed: @user_location.location_speed, location_timestamp: @user_location.location_timestamp }
    assert_redirected_to user_location_path(assigns(:user_location))
  end

  test "should destroy user_location" do
    assert_difference('UserLocation.count', -1) do
      delete :destroy, id: @user_location
    end

    assert_redirected_to user_locations_path
  end
end
