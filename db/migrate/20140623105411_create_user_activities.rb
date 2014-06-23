class CreateUserActivities < ActiveRecord::Migration
  def change
    create_table :user_activities do |t|
      t.datetime :activity_timestamp
      t.string :activity_name
      t.integer :activity_type
      t.integer :activity_confidence
      t.integer :device_id

      t.timestamps
    end
  end
end
