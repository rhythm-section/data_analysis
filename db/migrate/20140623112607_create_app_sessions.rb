class CreateAppSessions < ActiveRecord::Migration
  def change
    create_table :app_sessions do |t|
      t.timestamp :app_session_timestamp_start
      t.datetime :app_session_timestamp_end
      t.datetime :app_session_timestamp_duration
      t.integer :device_id

      t.timestamps
    end
  end
end
