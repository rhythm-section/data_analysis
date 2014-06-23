json.array!(@user_activities) do |user_activity|
  json.extract! user_activity, :id, :activity_timestamp, :activity_name, :activity_type, :activity_confidence, :device_id
  json.url user_activity_url(user_activity, format: :json)
end
