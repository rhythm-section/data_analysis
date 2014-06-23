json.array!(@app_usages) do |app_usage|
  json.extract! app_usage, :id, :app_name, :package_name, :version_name, :version_code, :base_activity, :top_activity, :first_install_time, :last_update_time, :app_session_id
  json.url app_usage_url(app_usage, format: :json)
end
