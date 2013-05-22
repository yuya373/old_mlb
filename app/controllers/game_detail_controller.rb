require 'open-uri'
class GameDetailController < ApplicationController

	def index

	end


	def game_details
		team_name = params[:team_name].to_s
		year = params[:year].to_i
		month = params[:month].to_i
		day = params[:day].to_i
		uu = build_score_board_url(year,month,day)
		gid = get_gid(team_name,year,month,day)
		url = build_game_details_url(gid)
		doc = Nokogiri::XML(open(url))

		doc.css()
	end

	def players
		base_url = build_game_details_url
		players_url = base_url + '/players.xml'
		doc = Nokogiri::XML(open(players_url))
	end

end
