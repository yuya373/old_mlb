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

		@data = {}

		boxscore = doc.css('boxscore')
		@data[:venue] = boxscore.attribute('venue_name').text
		@data[:away_fname] = boxscore.attribute('away_fname').text
		@data[:home_fname] = boxscore.attribute('home_fname').text
		@data[:away_sname] = boxscore.attribute('away_sname').text
		@data[:home_sname] = boxscore.attribute('home_sname').text
		@data[:away_wins] = boxscore.attribute('away_wins').text
		@data[:away_loss] = boxscore.attribute('away_loss').text
		@data[:home_wins] = boxscore.attribute('home_wins').text
		@data[:home_loss] = boxscore.attribute('home_loss').text

		@data[:linescore] = {}

		linescore = doc.css('boxscore>linescore')
		@data[:linescore][:away_team_runs] = linescore.attribute('away_team_runs').text
		@data[:linescore][:home_team_runs] = linescore.attribute('home_team_runs').text
		@data[:linescore][:away_team_hits] = linescore.attribute('away_team_hits').text
		@data[:linescore][:home_team_hits] = linescore.attribute('home_team_hits').text
		@data[:linescore][:away_team_errors] = linescore.attribute('away_team_errors').text
		@data[:linescore][:home_team_errors] = linescore.attribute('home_team_errors').text


		@data[:inning_line_score] = {}


		inning_line_score = linescore.css('inning_line_score')
		inn_number = 1

		inning_line_score.each do |inn|

			@data[:inning_line_score][inn_number] = {}

			@data[:inning_line_score][inn_number][:away] = inn.attribute('away').to_s
			@data[:inning_line_score][inn_number][:home] = inn.attribute('home').to_s

			inn_number += 1
		end



		@data[:pitching] = {}


		pitching = doc.css('boxscore>pitching')

		pitching.each do |pitch|

			pitcher_flag = pitch.attribute('team_flag').to_s.to_sym
			@data[:pitching][pitcher_flag] = {}

			@data[:pitching][pitcher_flag][:out] = pitch.attribute('out').to_s
			@data[:pitching][pitcher_flag][:h] = pitch.attribute('h').to_s
			@data[:pitching][pitcher_flag][:r] = pitch.attribute('r').to_s
			@data[:pitching][pitcher_flag][:er] = pitch.attribute('er').to_s
			@data[:pitching][pitcher_flag][:bb] = pitch.attribute('bb').to_s
			@data[:pitching][pitcher_flag][:so] = pitch.attribute('so').to_s
			@data[:pitching][pitcher_flag][:hr] = pitch.attribute('bf').to_s
			@data[:pitching][pitcher_flag][:era] = pitch.attribute('era').to_s

			pitcher_number = 1




			pitcher = pitch.css('pitcher')

			pitcher.each do  |pitcher|

				@data[:pitching][pitcher_flag][pitcher_number] = {}

				@data[:pitching][pitcher_flag][pitcher_number][:id] = pitcher.attribute('id').to_s
				@data[:pitching][pitcher_flag][pitcher_number][:name] = pitcher.attribute('name_display_first_last').to_s
				@data[:pitching][pitcher_flag][pitcher_number][:out] = pitcher.attribute('out').to_s
				@data[:pitching][pitcher_flag][pitcher_number][:bf] = pitcher.attribute('bf').to_s
				@data[:pitching][pitcher_flag][pitcher_number][:er] = pitcher.attribute('er').to_s
				@data[:pitching][pitcher_flag][pitcher_number][:r] = pitcher.attribute('r').to_s
				@data[:pitching][pitcher_flag][pitcher_number][:h] = pitcher.attribute('h').to_s
				@data[:pitching][pitcher_flag][pitcher_number][:so] = pitcher.attribute('so').to_s
				@data[:pitching][pitcher_flag][pitcher_number][:hr] = pitcher.attribute('hr').to_s
				@data[:pitching][pitcher_flag][pitcher_number][:bb] = pitcher.attribute('bb').to_s
				@data[:pitching][pitcher_flag][pitcher_number][:np] = pitcher.attribute('np').to_s
				@data[:pitching][pitcher_flag][pitcher_number][:s] = pitcher.attribute('s').to_s
				@data[:pitching][pitcher_flag][pitcher_number][:w] = pitcher.attribute('w').to_s
				@data[:pitching][pitcher_flag][pitcher_number][:l] = pitcher.attribute('l').to_s
				@data[:pitching][pitcher_flag][pitcher_number][:sv] = pitcher.attribute('sv').to_s
				@data[:pitching][pitcher_flag][pitcher_number][:bs] = pitcher.attribute('bs').to_s
				@data[:pitching][pitcher_flag][pitcher_number][:hld] = pitcher.attribute('hld').to_s
				@data[:pitching][pitcher_flag][pitcher_number][:s_ip] = pitcher.attribute('s_ip').to_s
				@data[:pitching][pitcher_flag][pitcher_number][:s_h] = pitcher.attribute('s_h').to_s
				@data[:pitching][pitcher_flag][pitcher_number][:s_er] = pitcher.attribute('s_er').to_s
				@data[:pitching][pitcher_flag][pitcher_number][:s_bb] = pitcher.attribute('s_bb').to_s
				@data[:pitching][pitcher_flag][pitcher_number][:s_so] = pitcher.attribute('s_so').to_s
				@data[:pitching][pitcher_flag][pitcher_number][:era] = pitcher.attribute('era').to_s
				@data[:pitching][pitcher_flag][pitcher_number][:loss] = pitcher.attribute('loss').to_s
				@data[:pitching][pitcher_flag][pitcher_number][:note] = pitcher.attribute('note').to_s

				pitcher_number += 1
			end
		end





		batting = doc.css('boxscore>batting')

		@data[:batting] = {}

		batting.each do |bat|
			batter_flag = bat.attribute('team_flag').to_s.to_sym
			@data[:batting][batter_flag] = {}



			@data[:batting][batter_flag][:ab] = bat.attribute('ab').to_s
			@data[:batting][batter_flag][:r] = bat.attribute('r').to_s
			@data[:batting][batter_flag][:h] = bat.attribute('h').to_s
			@data[:batting][batter_flag][:d] = bat.attribute('d').to_s
			@data[:batting][batter_flag][:t] = bat.attribute('t').to_s
			@data[:batting][batter_flag][:hr] = bat.attribute('hr').to_s
			@data[:batting][batter_flag][:rbi] = bat.attribute('rbi').to_s
			@data[:batting][batter_flag][:bb] = bat.attribute('bb').to_s
			@data[:batting][batter_flag][:po] = bat.attribute('po').to_s
			@data[:batting][batter_flag][:da] = bat.attribute('da').to_s
			@data[:batting][batter_flag][:so] = bat.attribute('so').to_s
			@data[:batting][batter_flag][:lob] = bat.attribute('lob').to_s
			@data[:batting][batter_flag][:avg] = bat.attribute('avg').to_s

			batter_number = 1



			bat.css('batter').each do |batter|
				@data[:batting][batter_flag][batter_number] = {}

				@data[:batting][batter_flag][batter_number][:id] = batter.attribute('id').to_s
				@data[:batting][batter_flag][batter_number][:name] = batter.attribute('name_display_first_last').to_s
				@data[:batting][batter_flag][batter_number][:pos] = batter.attribute('pos').to_s
				@data[:batting][batter_flag][batter_number][:bo] = batter.attribute('bo').to_s
				@data[:batting][batter_flag][batter_number][:ab] = batter.attribute('ab').to_s
				@data[:batting][batter_flag][batter_number][:po] = batter.attribute('po').to_s
				@data[:batting][batter_flag][batter_number][:r] = batter.attribute('r').to_s
				@data[:batting][batter_flag][batter_number][:a] = batter.attribute('a').to_s
				@data[:batting][batter_flag][batter_number][:bb] = batter.attribute('bb').to_s
				@data[:batting][batter_flag][batter_number][:sac] = batter.attribute('sac').to_s
				@data[:batting][batter_flag][batter_number][:t] = batter.attribute('t').to_s
				@data[:batting][batter_flag][batter_number][:sf] = batter.attribute('sf').to_s
				@data[:batting][batter_flag][batter_number][:h] = batter.attribute('h').to_s
				@data[:batting][batter_flag][batter_number][:e] = batter.attribute('e').to_s
				@data[:batting][batter_flag][batter_number][:d] = batter.attribute('d').to_s
				@data[:batting][batter_flag][batter_number][:hbp] = batter.attribute('hbp').to_s
				@data[:batting][batter_flag][batter_number][:so] = batter.attribute('so').to_s
				@data[:batting][batter_flag][batter_number][:hr] = batter.attribute('hr').to_s
				@data[:batting][batter_flag][batter_number][:rbi] = batter.attribute('rbi').to_s
				@data[:batting][batter_flag][batter_number][:lob] = batter.attribute('lob').to_s
				@data[:batting][batter_flag][batter_number][:fldg] = batter.attribute('fldg').to_s
				@data[:batting][batter_flag][batter_number][:sb] = batter.attribute('sb').to_s
				@data[:batting][batter_flag][batter_number][:cs] = batter.attribute('cs').to_s
				@data[:batting][batter_flag][batter_number][:s_hr] = batter.attribute('s_hr').to_s
				@data[:batting][batter_flag][batter_number][:s_rbi] = batter.attribute('s_rbi').to_s
				@data[:batting][batter_flag][batter_number][:s_h] = batter.attribute('s_h').to_s
				@data[:batting][batter_flag][batter_number][:s_bb] = batter.attribute('s_bb').to_s
				@data[:batting][batter_flag][batter_number][:s_r] = batter.attribute('s_r').to_s
				@data[:batting][batter_flag][batter_number][:s_so] = batter.attribute('s_so').to_s
				@data[:batting][batter_flag][batter_number][:avg] = batter.attribute('avg').to_s
				@data[:batting][batter_flag][batter_number][:go] = batter.attribute('go').to_s
				@data[:batting][batter_flag][batter_number][:ao] = batter.attribute('ao').to_s

				batter_number += 1
			end
		end












	end

	def players
		base_url = build_game_details_url
		players_url = base_url + '/players.xml'
		doc = Nokogiri::XML(open(players_url))
	end

end
