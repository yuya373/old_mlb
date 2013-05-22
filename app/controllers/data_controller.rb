require 'open-uri'
class DataController < ApplicationController
  before_action :set_datum, only: [:show, :edit, :update, :destroy]

  # GET /data
  # GET /data.json
  def index

    @data = Datum.all
  end

  def get_date

    @data_fetchers = DataFetcher.all

  end

  # GET /data/1
  # GET /data/1.json
  def show
  end

  # GET /data/new
  def new
    @datum = Datum.new
  end

  # GET /data/1/edit
  def edit
  end

  # POST /data
  # POST /data.json
  def create
    @datum = Datum.new(datum_params)

    year = @datum.year
    month = @datum.month
    day = @datum.day
    team_name = @datum.team_name

    url = build_score_board_url(year,month,day)
    doc = Nokogiri::XML(open (url))
    team = {}

    doc.css('game').each do |game|
      team[team_name] = {}

      if game.attribute('away_code').text == "#{team_name}"

        team[team_naem][:team_id] = game.attribute('away_team_id').text

        gid = game.attribute('gameday').text
        team[team_name][:gid] = gid

      elsif game.attribute('home_code').text =="#{team_name}"

        team[team_naem][:team_id] = game.attribute('home`_team_id').text

        gid = game.attribute('gameday').text
        team[team_name][:gid] = gid

      end


      # team[team_name][:id] = game.attribute('home_team_id').text
    end

    @datum.gid = team[team_name][:gid]


    respond_to do |format|
      if @datum.save
        format.html { redirect_to @datum, notice: 'Datum was successfully created.' }
        format.json { render action: 'show', status: :created, location: @datum }
      else
        format.html { render action: 'new' }
        format.json { render json: @datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /data/1
  # PATCH/PUT /data/1.json
  def update
    respond_to do |format|
      if @datum.update(datum_params)
        format.html { redirect_to @datum, notice: 'Datum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /data/1
  # DELETE /data/1.json
  def destroy
    @datum.destroy
    respond_to do |format|
      format.html { redirect_to data_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_datum
      @datum = Datum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def datum_params
      params.require(:datum).permit(:gid, :year, :month, :day, :team_name, :team_id)
    end
end
