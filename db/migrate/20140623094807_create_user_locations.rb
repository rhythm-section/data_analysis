class CreateUserLocations < ActiveRecord::Migration
  def change
    create_table :user_locations do |t|
      t.datetime :location_timestamp
      t.integer :location_elapsed_realtime_nanos
      t.string :location_provider
      t.float :location_latitude
      t.float :location_longitude
      t.float :location_altitude
      t.float :location_speed
      t.float :location_accuracy
      t.integer :location_app_session_id

      t.timestamps
    end
  end
end
