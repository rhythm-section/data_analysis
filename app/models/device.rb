class Device < ActiveRecord::Base
  has_many :user_locations
  has_many :user_activities
  has_many :app_sessions
  has_many :system_settings
end
