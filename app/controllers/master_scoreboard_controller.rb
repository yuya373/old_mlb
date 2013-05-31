require 'open-uri'

class MasterScoreboardController < ApplicationController

	def new

	end

	def get_scoreboard(url)
		doc = Nokogiri::XML(open(url))

		@game_data = {}
		number_of_games = 0

		doc.css('game').each do |game|

			@game_data[number_of_games] = {}

			key = game.keys.to_a

			key.each do |k|
				v = game.attribute(k).text
				@game_data[number_of_games][k.to_sym] = v
			end

			@game_data[number_of_games][:status] = {}

			game.css('status').each do |status|
				key = status.keys.to_a
				key.each do |k|
					v = status.attribute(k).text
					@game_data[number_of_games][:status][k.to_sym] = v
				end
			end

			case @game_data[number_of_games][:status][:ind]
				when 'S'

					@game_data[number_of_games][:home_probable_pitcher] = {}
					game.css('home_probable_pitcher').each do |hpp|
						key = hpp.keys.to_a
						key.each do |k|
							v = hpp.attribute(k).text
							@game_data[number_of_games][:home_probable_pitcher][k.to_sym] = v
						end
					end

					@game_data[number_of_games][:away_probable_pitcher] = {}
					game.css('away_probable_pitcher').each do |app|
						key = app.keys.to_a
						key.each do |k|
							v = app.attribute(k).text
							@game_data[number_of_games][:away_probable_pitcher][k.to_sym] = v
						end
					end
					number_of_games += 1

				when 'DR'
					number_of_games += 1

				when 'I'
					@game_data[number_of_games][:linescore] = {}
					inn_number = 0
					@game_data[number_of_games][:linescore][:inning] = {}

					game.css('linescore').each do |linescore|
						linescore.css('inning').each do |inning|
							key = inning.keys.to_a
							@game_data[number_of_games][:linescore][:inning][inn_number] = {}
							key.each do |k|
								v = inning.attribute(k).text
								@game_data[number_of_games][:linescore][:inning][inn_number][k.to_sym] = v
							end
							inn_number += 1
						end

						@game_data[number_of_games][:linescore][:r] = {}

						linescore.css('r').each do |r|
							key = r.keys.to_a
							key.each do |k|
								v = r.attribute(k).text
								@game_data[number_of_games][:linescore][:r][k.to_sym] = v
							end
						end

						@game_data[number_of_games][:linescore][:h] = {}

						linescore.css('h').each do |h|
							key = h.keys.to_a
							key.each do |k|
								v = h.attribute(k).text
								@game_data[number_of_games][:linescore][:h][k.to_sym] = v
							end
						end

						@game_data[number_of_games][:linescore][:e] = {}

						linescore.css('e').each do |e|
							key = e.keys.to_a
							key.each do |k|
								v = e.attribute(k).text
								@game_data[number_of_games][:linescore][:e][k.to_sym] = v
							end
						end
					end
					number_of_games += 1


				when 'F'

					@game_data[number_of_games][:linescore] = {}
					inn_number = 0
					@game_data[number_of_games][:linescore][:inning] = {}

					game.css('linescore').each do |linescore|

						# イニングごとのスコア
						linescore.css('inning').each do |inn|

							key = inn.keys.to_a
							@game_data[number_of_games][:linescore][:inning][inn_number] = {}

							key.each do |k|
								v = inn.attribute(k).text
								@game_data[number_of_games][:linescore][:inning][inn_number][k.to_sym] = v
							end
							inn_number += 1
						end

						if @game_data[number_of_games][:linescore][:inning][8].has_key?(:home)
						else
							@game_data[number_of_games][:linescore][:inning][8][:home] = 'x'
						end


						@game_data[number_of_games][:linescore][:r] = {}
						linescore.css('r').each do |r|
							key = r.keys.to_a
							key.each do |k|
								v = r.attribute(k).text
								@game_data[number_of_games][:linescore][:r][k.to_sym] = v
							end
						end

						@game_data[number_of_games][:linescore][:e] = {}
						linescore.css('e').each do |e|
							key = e.keys.to_a
							key.each do |k|
								v = e.attribute(k).text
								@game_data[number_of_games][:linescore][:e][k.to_sym] = v
							end
						end

						@game_data[number_of_games][:linescore][:h] = {}
						linescore.css('h').each do |h|
							key = h.keys.to_a
							key.each do |k|
								v = h.attribute(k).text
								@game_data[number_of_games][:linescore][:h][k.to_sym] = v
							end
						end

						@game_data[number_of_games][:linescore][:hr] = {}
						linescore.css('hr').each do |hr|
							key = hr.keys.to_a
							key.each do |k|
								v = hr.attribute(k).text
								@game_data[number_of_games][:linescore][:hr][k.to_sym] = v
							end
						end

						@game_data[number_of_games][:linescore][:sb] = {}
						linescore.css('sb').each do |sb|
							key = sb.keys.to_a
							key.each do |k|
								v = sb.attribute(k).text
								@game_data[number_of_games][:linescore][:sb][k.to_sym] = v
							end
						end

						@game_data[number_of_games][:linescore][:so] = {}
						linescore.css('so').each do |so|
							key = so.keys.to_a
							key.each do |k|
								v = so.attribute(k).text
								@game_data[number_of_games][:linescore][:so][k.to_sym] = v
							end
						end
					end

					@game_data[number_of_games][:home_runs] = {}
					hr_num = 0

					game.css('home_runs>player').each do |hr|
						@game_data[number_of_games][:home_runs][hr_num] = {}
						key = hr.keys.to_a
						key.each do |k|
							v = hr.attribute(k).text
							@game_data[number_of_games][:home_runs][hr_num][k.to_sym] = v
						end
						hr_num += 1
					end

					@game_data[number_of_games][:winning_pitcher] = {}

					game.css('winning_pitcher').each do |win|
						key = win.keys.to_a
						key.each do |k|
							v = win.attribute(k).text
							@game_data[number_of_games][:winning_pitcher][k.to_sym] = v
						end
					end

					@game_data[number_of_games][:losing_pitcher] = {}

					game.css('losing_pitcher').each do |lose|
						key = lose.keys.to_a
						key.each do |k|
							v = lose.attribute(k).text
							@game_data[number_of_games][:losing_pitcher][k.to_sym] = v
						end
					end

					@game_data[number_of_games][:save_pitcher] = {}

					game.css('save_pitcher').each do |save|
						key = save.keys.to_a
						key.each do |k|
							v = save.attribute(k).text
							@game_data[number_of_games][:save_pitcher][k.to_sym] = v
						end
					end

					number_of_games += 1
			end
		end

		return @game_data
	end

	def today_score
		url = build_today
		get_scoreboard(url)
	end

	def create
		year = params[:year].to_i
		month = params[:month].to_i
		day = params[:day].to_i
		url = build_score_board_url(year,month,day)

		get_scoreboard(url)




		# doc = Nokogiri::XML(open(url))

		# @game_data = {}
		# number_of_games = 0
		# doc.css('game').each do |game|

		# 		@game_data[number_of_games]={}

		# 		@game_data[number_of_games][:away_team_name] = game.attribute('away_team_name').text
		# 		@game_data[number_of_games][:away_team_win] = game.attribute('away_win').text
		# 		@game_data[number_of_games][:away_team_lose] = game.attribute('away_loss').text

		# 		@game_data[number_of_games][:home_team_name] = game.attribute('home_team_name').text
		# 		@game_data[number_of_games][:home_team_win] = game.attribute('home_win').text
		# 		@game_data[number_of_games][:home_team_lose] = game.attribute('home_loss').text

		# 		@game_data[number_of_games][:venue] = game.attribute('venue').text
		# 		@game_data[number_of_games][:gid] = game.attribute('gameday').text



		# 	if game.css('status').attribute('status').text == 'Postponed'
		# 	 	@game_data[number_of_games][:status] = 'Postponed'
		# 	 else

		# 	 	@game_data[number_of_games][:status] = game.css('status').attribute('ind').text


		# 		game.css('linescore').each do |score|

		# 			number = 1
		# 	 		@game_data[number_of_games][:score] = {}



		# 			score.css('inning').each do |inn|

		# 				@game_data[number_of_games][:score][number] = {}
		# 				@game_data[number_of_games][:score][number][:away] = {}
		# 				@game_data[number_of_games][:score][number][:home] = {}

		# 				@game_data[number_of_games][:score][number][:away] = inn.attribute('away').text

		# 				if inn.key?('home')

		# 					@game_data[number_of_games][:score][number][:home] = inn.attribute('home').text

		# 				else
		# 					@game_data[number_of_games][:score][number][:home] = '/'
		# 				end
		# 				number +=1
		# 			end

		# 			@game_data[number_of_games][:away_run] = score.css('r').attribute('away').text
		# 			@game_data[number_of_games][:home_run] = score.css('r').attribute('home').text
		# 			@game_data[number_of_games][:away_hit] = score.css('h').attribute('away').text
		# 			@game_data[number_of_games][:home_hit] = score.css('h').attribute('home').text
		# 			@game_data[number_of_games][:away_er] = score.css('e').attribute('away').text
		# 			@game_data[number_of_games][:home_er] = score.css('e').attribute('home').text



		# 			if score.css('hr').empty?
		# 			else

		# 				@game_data[number_of_games][:away_hr] = score.css('hr').attribute('away').text
		# 				@game_data[number_of_games][:home_hr] = score.css('hr').attribute('home').text

		# 			end

		# 			if game.css('linescore hr').empty?
		# 			else

		# 				hr_player = 0

		# 				game.css('home_runs player').each do |hr|
		# 					@game_data[number_of_games][hr_player] = {}
		# 				@game_data[number_of_games][hr_player][:hr_player_name] = hr.attribute('first').text + ' ' + hr.attribute('last').text
		# 				@game_data[number_of_games][hr_player][:hr_player_hr_number] = hr.attribute('hr').text
		# 				@game_data[number_of_games][hr_player][:hr_player_hr_inning] = hr.attribute('inning').text
		# 				@game_data[number_of_games][hr_player][:hrp_id] = hr.attribute('id').text
		# 				hr_player += 1

		# 				end
		# 			end

		# 			if score.css('sb').empty?
		# 				else
		# 					@game_data[number_of_games][:away_sb] = score.css('sb').attribute('away').text
		# 					@game_data[number_of_games][:home_sb] = score.css('sb').attribute('home').text
		# 			end

		# 			if score.css('so').empty?
		# 				else
		# 					@game_data[number_of_games][:away_so] = score.css('so').attribute('away').text
		# 					@game_data[number_of_games][:home_so] = score.css('so').attribute('home').text
		# 			end
		# 		end

		# 		if game.css('status').attribute('ind').text == 'I'
		# 		else


		# 			if game.css('winning_pitcher').empty?
		# 			else
		# 				@game_data[number_of_games][:winning_pitcher] = game.css('winning_pitcher').attribute('first').text + " " + game.css('winning_pitcher').attribute('last').text
		# 				@game_data[number_of_games][:winning_pitcher_win] = game.css('winning_pitcher').attribute('wins').text
		# 				@game_data[number_of_games][:winning_pitcher_lose] = game.css('winning_pitcher').attribute('losses').text
		# 				@game_data[number_of_games][:winning_pitcher_era] = game.css('winning_pitcher').attribute('era').text
		# 				@game_data[number_of_games][:wp_id] = game.css('winning_pitcher').attribute('id').text

		# 				@game_data[number_of_games][:losing_pitcher] = game.css('losing_pitcher').attribute('first').text + " " + game.css('losing_pitcher').attribute('last').text
		# 				@game_data[number_of_games][:losing_pitcher_win] = game.css('losing_pitcher').attribute('wins').text
		# 				@game_data[number_of_games][:losing_pitcher_lose] = game.css('losing_pitcher').attribute('losses').text
		# 				@game_data[number_of_games][:losing_pitcher_era] = game.css('losing_pitcher').attribute('era').text
		# 				@game_data[number_of_games][:lp_id] = game.css('losing_pitcher').attribute('id').text
		# 			end


		# 		  if game.css('save_pitcher').attribute('id') == ' '

		# 		  	else
		# 			  	@game_data[number_of_games][:save_pitcher] = game.css('save_pitcher').attribute('first').text + " " + game.css('save_pitcher').attribute('last').text
		# 			  	@game_data[number_of_games][:save_pitcher_win] = game.css('save_pitcher').attribute('wins').text
		# 			  	@game_data[number_of_games][:save_pitcher_lose] = game.css('save_pitcher').attribute('losses').text
		# 			  	@game_data[number_of_games][:save_pitcher_save] = game.css('save_pitcher').attribute('saves').text
		# 			  	@game_data[number_of_games][:save_pitcher_era] = game.css('save_pitcher').attribute('era').text
		# 			  	@game_data[number_of_games][:save_pitcher_svo] = game.css('save_pitcher').attribute('svo').text
		# 			  	@game_data[number_of_games][:sp_id] = game.css('save_pitcher').attribute('id').text
		# 			end
		# 		end
		# 		number_of_games += 1
		# 	end
		# end
	end
end
