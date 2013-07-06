require 'open-uri'
class GameDetailController < ApplicationController

	def index

	end


	def game_details
		if params[:gid] == nil
			team_name = params[:team_name].to_s
			year = params[:year].to_i
			month = params[:month].to_i
			day = params[:day].to_i
			@gid = get_gid(team_name,year,month,day)
			if @gid[0] == 'no-game'
				@nogame = "no-game"
			else
				@nogame = nil
				gameday = @gid[0]
				@url = build_game_details_url(gameday)
			end
		else
			@gid = params[:gid]
			@url = build_game_details_url(@gid)
		end

		if @nogame == nil
				doc = Nokogiri::XML(open(@url))

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
				@data[:status_ind] = boxscore.attribute('status_ind').text

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
					key = pitch.keys.to_a
					key.each do |k|
						v = pitch.attribute(k).text
						@data[:pitching][pitcher_flag][k.to_sym] = v
					end

					pitcher_number = 1

					pitcher = pitch.css('pitcher')

					pitcher.each do  |pitcher|
						@data[:pitching][pitcher_flag][pitcher_number] = {}
						key = [
							'id',
							'name_display_first_last',
							'note',
							'era',
							'out',
							'np',
							's',
							'bf',
							'h',
							'so',
							'hr',
							'bb',
							'er',
							'r',
							'w',
							'l',
							'hld',
							'sv',
							'bs',
							's_ip',
							's_h',
							's_r',
							's_er',
							's_bb',
							's_so']

						key.each do |k|

							v = pitcher.attribute(k)
							@data[:pitching][pitcher_flag][pitcher_number][k.to_sym] = v
							if not @data[:pitching][pitcher_flag][pitcher_number].has_key?(:note)
								@data[:pitching][pitcher_flag][pitcher_number][:note] = "-"
							end
						end
						pitcher_number += 1
					end
				end

				batting = doc.css('boxscore>batting')

				@data[:batting] = {}

				batting.each do |bat|
					batter_flag = bat.attribute('team_flag').to_s.to_sym
					@data[:batting][batter_flag] = {}
					key = bat.keys.to_a
					key.each do |k|
						v = bat.attribute(k).text
						@data[:batting][batter_flag][k.to_sym] = v
					end

					batter_number = 1

					bat.css('batter').each do |batter|
						@data[:batting][batter_flag][batter_number] = {}
						key = [
						'id',
						'name',
						'name_display_first_last',
						'pos',
						'bo',
						'avg',
						'ab',
						'h',
						'd',
						't',
						'hr',
						'so',
						'go',
						'ao',
						'bb',
						'hbp',
						'r',
						'rbi',
						'lob',
						'sb',
						'cs',
						'sac',
						'sf',
						'a',
						'po',
						'e',
						'fldg',
						's_h',
						's_hr',
						's_so',
						's_bb',
						's_r',
						's_rbi'
					]
						key.delete('note')
						key.each do |k|
							v = batter.attribute(k)
							@data[:batting][batter_flag][batter_number][k.to_sym] = v
							# if not @data[:batting][batter_flag][batter_number].has_key?(:go)

							# 	@data[:batting][batter_flag][batter_number][:go] = 0
							# end
						end
						batter_number += 1
					end
				end
			end
		end
	end
