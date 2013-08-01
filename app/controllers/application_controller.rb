require 'open-uri'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def sort(default)
    case params[:sort]
    when nil
      @sort = default.to_s
    else
      @sort = params[:sort]
    end

    if @sort == session[:sort]
      session[:direction] = session[:direction] == 'asc' ? 'desc' : 'asc'
      @direction = session[:direction]
    else
      @direction = 'desc'
    end

    session[:sort] = @sort
    session[:direction] = @direction
    return [@sort,@direction]
  end

  def build_team_url(id)
    url = "http://gd2.mlb.com/components/team/stats/#{id}-stats.xml"
  end

  def build_today
    date = Date.yesterday.to_s
    year = date.slice(0,4)
    month = date.slice(5,2)
    day = date.slice(8,2)

    url =  "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/master_scoreboard.xml"

  end

  def build_score_board_url(year,month,day)
		date = Date.new(year,month,day).to_s
		year = date.slice(0,4)
		month = date.slice(5,2)
		day = date.slice(8,2)


		url =  "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/master_scoreboard.xml"
	end

	def build_game_details_url(gid)
    #2013_05_01_nynmlb_miamlb_1
		year = gid.slice(0,4)
		month = gid.slice(5,2)
		day = gid.slice(8,2)
		url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{gid}/boxscore.xml"
	end

  def build_pitchers_url(gid,p_id)
    year = gid.slice(0,4)
    month = gid.slice(5,2)
    day = gid.slice(8,2)
    away_team = gid.slice(11,6)
    home_team = gid.slice(18,6)
    num = gid.slice(25,1)

    url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/pitchers/#{p_id}.xml"
  end

  def build_batters_url(gid,b_id)
    year = gid.slice(0,4)
    month = gid.slice(5,2)
    day = gid.slice(8,2)
    # 2013/06/01/wasmlb-atlmlb-1
    away_team = gid.slice(11,6)
    home_team = gid.slice(18,6)
    num = gid.slice(25,1)
    url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/batters/#{b_id}.xml"
  end

	def get_gid(team_name,year,month,day)

		url = build_score_board_url(year,month,day)
    doc = Nokogiri::XML(open(url))

    # team = {}
    name = team_name
    gid = []
    doc.css('game').each do |game|
      # team[team_name] = {}

      if game.attribute('away_code').text == name

        # team[team_name][:team_id] = game.attribute('away_team_id').text

        gid << game.attribute('gameday').text

      elsif game.attribute('home_code').text == name

        # team[team_name][:team_id] = game.attribute('home_team_id').text

       gid << game.attribute('gameday').text

      end
    end
    return gid
  end

  helper_method :current_user

  private
    def current_user
      @current_user ||= User.where("id = ?",session[:user_id]).first if session[:user_id]
    end

end
