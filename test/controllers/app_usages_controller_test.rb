require 'test_helper'

class AppUsagesControllerTest < ActionController::TestCase
  setup do
    @app_usage = app_usages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:app_usages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create app_usage" do
    assert_difference('AppUsage.count') do
      post :create, app_usage: { app_name: @app_usage.app_name, app_session_id: @app_usage.app_session_id, base_activity: @app_usage.base_activity, first_install_time: @app_usage.first_install_time, last_update_time: @app_usage.last_update_time, package_name: @app_usage.package_name, top_activity: @app_usage.top_activity, version_code: @app_usage.version_code, version_name: @app_usage.version_name }
    end

    assert_redirected_to app_usage_path(assigns(:app_usage))
  end

  test "should show app_usage" do
    get :show, id: @app_usage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @app_usage
    assert_response :success
  end

  test "should update app_usage" do
    patch :update, id: @app_usage, app_usage: { app_name: @app_usage.app_name, app_session_id: @app_usage.app_session_id, base_activity: @app_usage.base_activity, first_install_time: @app_usage.first_install_time, last_update_time: @app_usage.last_update_time, package_name: @app_usage.package_name, top_activity: @app_usage.top_activity, version_code: @app_usage.version_code, version_name: @app_usage.version_name }
    assert_redirected_to app_usage_path(assigns(:app_usage))
  end

  test "should destroy app_usage" do
    assert_difference('AppUsage.count', -1) do
      delete :destroy, id: @app_usage
    end

    assert_redirected_to app_usages_path
  end
end
