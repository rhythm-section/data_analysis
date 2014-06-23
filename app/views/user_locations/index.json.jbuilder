json.array!(@user_locations) do |user_location|
  json.extract! user_location, :id, :location_timestamp, :location_elapsed_realtime_nanos, :location_provider, :location_latitude, :location_longitude, :location_altitude, :location_speed, :location_accuracy, :location_app_session_id
  json.url user_location_url(user_location, format: :json)
end
