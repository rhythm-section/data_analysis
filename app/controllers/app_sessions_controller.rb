class AppSessionsController < ApplicationController
  before_action :set_app_session, only: [:show, :edit, :update, :destroy]

  # GET /app_sessions
  # GET /app_sessions.json
  def index
    @app_sessions = AppSession.all
  end

  # GET /app_sessions/1
  # GET /app_sessions/1.json
  def show
  end

  # GET /app_sessions/new
  def new
    @app_session = AppSession.new
  end

  # GET /app_sessions/1/edit
  def edit
  end

  # POST /app_sessions
  # POST /app_sessions.json
  def create
    @app_session = AppSession.new(app_session_params)

    respond_to do |format|
      if @app_session.save
        format.html { redirect_to @app_session, notice: 'App session was successfully created.' }
        format.json { render :show, status: :created, location: @app_session }
      else
        format.html { render :new }
        format.json { render json: @app_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /app_sessions/1
  # PATCH/PUT /app_sessions/1.json
  def update
    respond_to do |format|
      if @app_session.update(app_session_params)
        format.html { redirect_to @app_session, notice: 'App session was successfully updated.' }
        format.json { render :show, status: :ok, location: @app_session }
      else
        format.html { render :edit }
        format.json { render json: @app_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /app_sessions/1
  # DELETE /app_sessions/1.json
  def destroy
    @app_session.destroy
    respond_to do |format|
      format.html { redirect_to app_sessions_url, notice: 'App session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app_session
      @app_session = AppSession.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_session_params
      params.require(:app_session).permit(:app_session_timestamp_start, :app_session_timestamp_end, :app_session_timestamp_duration, :device_id)
    end
end
