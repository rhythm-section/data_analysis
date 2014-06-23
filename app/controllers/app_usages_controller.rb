class AppUsagesController < ApplicationController
  before_action :set_app_usage, only: [:show, :edit, :update, :destroy]

  # GET /app_usages
  # GET /app_usages.json
  def index
    @app_usages = AppUsage.all
  end

  # GET /app_usages/1
  # GET /app_usages/1.json
  def show
  end

  # GET /app_usages/new
  def new
    @app_usage = AppUsage.new
  end

  # GET /app_usages/1/edit
  def edit
  end

  # POST /app_usages
  # POST /app_usages.json
  def create
    @app_usage = AppUsage.new(app_usage_params)

    respond_to do |format|
      if @app_usage.save
        format.html { redirect_to @app_usage, notice: 'App usage was successfully created.' }
        format.json { render :show, status: :created, location: @app_usage }
      else
        format.html { render :new }
        format.json { render json: @app_usage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /app_usages/1
  # PATCH/PUT /app_usages/1.json
  def update
    respond_to do |format|
      if @app_usage.update(app_usage_params)
        format.html { redirect_to @app_usage, notice: 'App usage was successfully updated.' }
        format.json { render :show, status: :ok, location: @app_usage }
      else
        format.html { render :edit }
        format.json { render json: @app_usage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /app_usages/1
  # DELETE /app_usages/1.json
  def destroy
    @app_usage.destroy
    respond_to do |format|
      format.html { redirect_to app_usages_url, notice: 'App usage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app_usage
      @app_usage = AppUsage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_usage_params
      params.require(:app_usage).permit(:app_name, :package_name, :version_name, :version_code, :base_activity, :top_activity, :first_install_time, :last_update_time, :app_session_id)
    end
end
