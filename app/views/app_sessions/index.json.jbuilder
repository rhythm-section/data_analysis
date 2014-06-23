json.array!(@app_sessions) do |app_session|
  json.extract! app_session, :id, :app_session_timestamp_start, :app_session_timestamp_end, :app_session_timestamp_duration, :device_id
  json.url app_session_url(app_session, format: :json)
end
