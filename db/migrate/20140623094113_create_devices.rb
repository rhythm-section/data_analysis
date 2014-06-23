class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :user_name
      t.string :mongo_id
      t.string :uuid
      t.string :android_id
      t.datetime :created_at
      t.string :os_version
      t.string :model
      t.string :product
      t.string :manufacturer
      t.string :brand
      t.integer :user_locations
      t.integer :user_activities
      t.integer :app_sessions

      t.timestamps
    end
  end
end
