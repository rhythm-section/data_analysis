json.array!(@devices) do |device|
  json.extract! device, :id, :user_name, :mongo_id, :uuid, :android_id, :created_at, :os_version, :model, :product, :manufacturer, :brand, :user_locations, :user_activities, :app_sessions
  json.url device_url(device, format: :json)
end
