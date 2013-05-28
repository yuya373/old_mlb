require 'open-uri'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def build_team_url(id)
    url = "http://gd2.mlb.com/components/team/stats/#{id}-stats.xml"
  end

  def build_today
    date = Date.today.to_s
    year = date.slice(0,4)
    month = date.slice(5,2)
    day_i = date.slice(8,2).to_i - 1
    day = day_i.to_s

    url =  "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/master_scoreboard.xml"

  end

  def build_score_board_url(year,month,day)
		date = Date.new(year,month,day).xmlschema
		year = date.slice(0,4)
		month = date.slice(5,2)
		day = date.slice(8,2)


		url =  "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/master_scoreboard.xml"
	end

	def build_game_details_url(gid)

		year = gid.slice(0,4)
		month = gid.slice(5,2)
		day = gid.slice(8,2)
		url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{gid}/boxscore.xml"
	end

  def build_pitchers_url(gid,p_id)
    year = gid.slice(0,4)
    month = gid.slice(5,2)
    day = gid.slice(8,2)
    url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{gid}/pitchers/#{p_id}.xml"
  end

  def build_batters_url(gid,b_id)
    year = gid.slice(0,4)
    month = gid.slice(5,2)
    day = gid.slice(8,2)
    url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{gid}/batters/#{b_id}.xml"
  end

	def get_gid(team_name,year,month,day)

		url = build_score_board_url(year,month,day)
    doc = Nokogiri::XML(open (url))

    # team = {}
    name = team_name

    doc.css('game').each do |game|
      # team[team_name] = {}

      if game.attribute('away_code').text === name.to_s

        # team[team_name][:team_id] = game.attribute('away_team_id').text

        return gid = game.attribute('gameday').text

      elsif game.attribute('home_code').text === name.to_s

        # team[team_name][:team_id] = game.attribute('home_team_id').text

       return gid = game.attribute('gameday').text

      end
    end
  end

end
