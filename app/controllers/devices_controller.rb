class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]

  # GET /devices
  # GET /devices.json
  def index
    @devices = Device.all
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
  end

  # GET /devices/new
  def new
    @device = Device.new
  end

  # GET /devices/1/edit
  def edit
  end

  # POST /devices
  # POST /devices.json
  def create
    # before filling the db with json data, remove all entries and reset autoincrement ids
    Device.delete_all
    ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'devices'")
    UserLocation.delete_all
    ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'user_locations'")
    UserActivity.delete_all
    ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'user_activities'")
    AppSession.delete_all
    ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'app_sessions'")
    AppUsage.delete_all
    ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'app_usages'")
    SystemSetting.delete_all
    ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'system_settings'")

    # Read file contents
    # http://stackoverflow.com/questions/2521053/how-to-read-a-user-uploaded-file-without-saving-it-to-the-database
    file_data = device_params[:json_file]
    if file_data.respond_to?(:read)
      json_contents = file_data.read
    elsif file_data.respond_to?(:path)
      json_contents = File.read(file_data.path)
    else
      logger.error "Bad file_data: #{file_data.class.name}: #{file_data.inspect}"
      json_contents = nil
    end

    if json_contents != nil
      @devices = JSON.parse(json_contents)

      @devices['mongoexport'].each do |device|
        generated_params = {}

        # device infos
        generated_params[:mongo_id] = device['_id']['$oid']
        generated_params[:uuid] = device['uuid']
        generated_params[:android_id] = device['system_infos']['android_id']
        generated_params[:user_name] = device['system_infos']['user_name']
        generated_params[:os_version] = device['system_infos']['os_version']
        generated_params[:model] = device['system_infos']['model']
        generated_params[:product] = device['system_infos']['product']
        generated_params[:manufacturer] = device['system_infos']['manufacturer']
        generated_params[:brand] = device['system_infos']['brand']
        generated_params[:created_at] = Time.at(device['created_at']['$date']/1000.0)
        generated_params[:updated_at] = Time.at(device['updated_at']['$date']/1000.0)

        @device = Device.new(generated_params)
        device_created = @device.save
        puts "Device ID: #{@device.id}"

        # if device_created && device['system_infos']['user_name'] == 'Thomas Kowar' then
        if device_created then
          # remove duplicates from app sessions
          if device['app_sessions'] != nil then
            app_sessions_no_duplicates = device['app_sessions'].uniq { |app_session| [ app_session['app_session_timestamp_start'], app_session['app_session_timestamp_end'], app_session['app_session_timestamp_duration'], app_session['server_sent'] ] }
            puts "Removed #{device['app_sessions'].length-app_sessions_no_duplicates.length} duplicate entries. From #{device['app_sessions'].length} to #{app_sessions_no_duplicates.length}"
          
            app_sessions = []
            app_sessions_no_duplicates.each_with_index do |app_session, index|
              # puts index
              app_sessions << index+1
            end
            puts "App Session IDs (App Sessions): #{app_sessions}"
          end

          if device['app_usages'] != nil then
            app_usages = []
            device['app_usages'].each do |app_usage|
              app_usages << app_usage['app_session_id']
              # puts "ID: #{app_usage['app_sessions_id']}"
              # app_usages << app_usage['app_sessions_id']
            end
            puts "App Session IDs (App Usages): #{app_usages.uniq}"
          end

          # related data: user locations
          if device['user_locations'] != nil then
            user_locations = []
            device['user_locations'].each do |user_location|
              user_location[:device_id] = @device.id
              user_locations << UserLocation.new(user_location.except('_id', 'server_sent'))
            end

            UserLocation.import user_locations
          end


          # related data: user activities
          if device['user_activities'] != nil then
            user_activities = []
            device['user_activities'].each do |user_activity|
              user_activity[:device_id] = @device.id
              user_activities << UserActivity.new(user_activity.except('_id', 'server_sent'))
            end

            # @device.user_activities.push(user_activities)
            UserActivity.import user_activities
          end

          # related data: app usages => WARNING: Have to be inserted before app_sessions (because of inserting IDs correctly)
          # if device['app_usages'] != nil then
          #   app_usages = []
          #   device['app_usages'].each do |app_usage|
          #     # puts "#{app_usage['app_session_id']}"
          #     puts "Last App Session Entry ID #{AppSession.last.id}"
          #     # app_usage['app_session_id'] = app_usage['app_session_id']
          #     app_usages << AppUsage.new(app_usage.except('_id', 'server_sent'))
          #   end
          #   AppUsage.import app_usages
          # end

          # related data: app sessions
          if app_sessions_no_duplicates != nil then
            app_sessions_no_duplicates.each_with_index do |app_session, index|
              app_session[:device_id] = @device.id
              app_session_id = index + 1

              # temp variable to get id
              app_session_temp = AppSession.new(app_session.except('_id', 'server_sent'))
              app_session_temp.save!

              puts "App Session Temp ID: #{app_session_temp.id}"
              puts "App Session ID: #{app_session_id}"

              # related data: app usages
              if device['app_usages'] != nil then
                # app_usages = []
                # device['app_usages'].each do |app_usage|
                #   app_usages << app_usage['app_session_id']
                # end
                # app_usages.uniq!

                app_usages_for_saved_app_session = device['app_usages'].select { |app_usage| app_usage['app_session_id'] == app_session_id }
                
                puts "App Usages: #{app_usages_for_saved_app_session}"
                if app_usages_for_saved_app_session != [] then
                  app_usages = []
                  app_usages_for_saved_app_session.each do |app_usage|
                    app_usage[:app_session_id] = app_session_temp.id
                    puts "App Usage saved with Session ID = #{app_session_temp.id}"
                    app_usages << AppUsage.new(app_usage.except('_id', 'server_sent'))
                  end
                  AppUsage.import app_usages
                end

                # puts "App Usage Session IDs: #{app_usages}"
              end
            end
          end

          # if device['app_sessions'] != nil then
          #   app_sessions = []
            
          #   device['app_sessions'].each do |app_session|

          #     app_session[:device_id] = @device.id
          #     app_session_temp = AppSession.new(app_session.except('_id', 'server_sent'))

          #     if device['app_usages'] != nil then
          #       # ActiveRecord::Base.transaction do
          #         app_usages = []
          #         device['app_usages'].each do |app_usage|
          #           app_usages << AppUsage.new(app_usage.except('_id', 'server_sent'))
          #           # app_usages.push HTMLEntities.new.encode "(#{app_usage['app_name']},
          #           #                   #{app_usage['package_name']},
          #           #                   #{app_usage['version_name']},
          #           #                   #{app_usage['version_code']},
          #           #                   #{app_usage['base_activity']},
          #           #                   #{app_usage['top_activity']},
          #           #                   #{app_usage['first_install_time']},
          #           #                   #{app_usage['last_update_time']},
          #           #                   #{app_usage['app_session_id']},
          #           #                   #{app_usage['created_at']},
          #           #                   #{app_usage['updated_at']}
          #           #                   )".to_s
          #         end

          #         AppUsage.import app_usages
          #         # app_session_temp.app_usages.push(app_usages)
          #         # sql = "INSERT INTO app_usages (`app_name`, `package_name`, `version_name`, `version_code`, `base_activity`, `top_activity`, `first_install_time`, `last_update_time`, `app_session_id`, `created_at`, `updated_at`) VALUES #{app_usages.join(", ")}"
          #         # ActiveRecord::Base.connection.execute(sql)
          #       # end
          #     end

          #     app_sessions << app_session_temp
          #   end

          #   # @device.app_sessions.push(app_sessions)
          #   AppSession.import app_sessions
          # end
        
          # related data: system settings
          if device['system_settings'] != nil then
            system_settings = []
            device['system_settings'].each do |system_setting|
              system_settings << SystemSetting.new(system_setting.except('_id', 'server_sent'))
            end
            # @device.system_settings.push(system_settings)
            SystemSetting.import system_settings
          end
        end

      end
    end

    # @device = Device.new(device_params)

    # UserLocationsController.new.create('test')

    respond_to do |format|
      format.html { render :new }
    end

    # respond_to do |format|
    #   if @device.save
    #     format.html { redirect_to @device, notice: 'Device was successfully created.' }
    #     format.json { render :show, status: :created, location: @device }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @device.errors, status: :unprocessable_entity }
    #   end
    # end    
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
    respond_to do |format|
      if @device.update(device_params)
        format.html { redirect_to @device, notice: 'Device was successfully updated.' }
        format.json { render :show, status: :ok, location: @device }
      else
        format.html { render :edit }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    @device.destroy
    respond_to do |format|
      format.html { redirect_to devices_url, notice: 'Device was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def delete_all
      Device.delete_all
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      # params.require(:device).permit(:user_name, :mongo_id, :uuid, :android_id, :created_at, :os_version, :model, :product, :manufacturer, :brand, :user_locations, :user_activities, :app_sessions)
      params.require(:device).permit(:json_file)
    end
end
