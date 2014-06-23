class CreateAppUsages < ActiveRecord::Migration
  def change
    create_table :app_usages do |t|
      t.string :app_name
      t.string :package_name
      t.string :version_name
      t.integer :version_code
      t.string :base_activity
      t.string :top_activity
      t.datetime :first_install_time
      t.datetime :last_update_time
      t.integer :app_session_id

      t.timestamps
    end
  end
end
