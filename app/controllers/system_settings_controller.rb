class SystemSettingsController < ApplicationController
  before_action :set_system_setting, only: [:show, :edit, :update, :destroy]

  # GET /system_settings
  # GET /system_settings.json
  def index
    @system_settings = SystemSetting.all
  end

  # GET /system_settings/1
  # GET /system_settings/1.json
  def show
  end

  # GET /system_settings/new
  def new
    @system_setting = SystemSetting.new
  end

  # GET /system_settings/1/edit
  def edit
  end

  # POST /system_settings
  # POST /system_settings.json
  def create
    @system_setting = SystemSetting.new(system_setting_params)

    respond_to do |format|
      if @system_setting.save
        format.html { redirect_to @system_setting, notice: 'System setting was successfully created.' }
        format.json { render :show, status: :created, location: @system_setting }
      else
        format.html { render :new }
        format.json { render json: @system_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /system_settings/1
  # PATCH/PUT /system_settings/1.json
  def update
    respond_to do |format|
      if @system_setting.update(system_setting_params)
        format.html { redirect_to @system_setting, notice: 'System setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @system_setting }
      else
        format.html { render :edit }
        format.json { render json: @system_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /system_settings/1
  # DELETE /system_settings/1.json
  def destroy
    @system_setting.destroy
    respond_to do |format|
      format.html { redirect_to system_settings_url, notice: 'System setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system_setting
      @system_setting = SystemSetting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def system_setting_params
      params.require(:system_setting).permit(:settings_timestamp, :settings_airplane_mode, :settings_bluetooth, :settings_data_roaming, :settings_development_settings_enabled, :settings_http_proxy, :settings_mode_ringer, :settings_volume_alarm, :settings_volume_music, :settings_volume_notification, :settings_volume_ring, :settings_volume_system, :settings_volume_voice, :settings_network_preference, :settings_stay_on_while_plugged_in, :settings_usb_mass_storage_enabled, :settings_wifi, :settings_wifi_ssid, :settings_location_mode_3, :settings_location_mode_17, :device_id)
    end
end
