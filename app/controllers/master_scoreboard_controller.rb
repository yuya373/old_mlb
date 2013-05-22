require 'open-uri'

class MasterScoreboardController < ApplicationController

	def new

	end

	def create
		year = params[:year].to_i
		month = params[:month].to_i
		day = params[:day].to_i
		team_name = params[:team_name]
		url = build_score_board_url(year,month,day)
		doc = Nokogiri::XML(open(url))
		cc = doc.css('game').class


		@game_data = {}
		number_of_games = 0
		doc.css('game').each do |game|


				@game_data[number_of_games]={}


				@game_data[number_of_games][:away_team_name] = game.attribute('away_team_name').text
				@game_data[number_of_games][:away_team_win] = game.attribute('away_win').text
				@game_data[number_of_games][:away_team_lose] = game.attribute('away_loss').text

				@game_data[number_of_games][:home_team_name] = game.attribute('home_team_name').text
				@game_data[number_of_games][:home_team_win] = game.attribute('home_win').text
				@game_data[number_of_games][:home_team_lose] = game.attribute('home_loss').text

				@game_data[number_of_games][:venue] = game.attribute('venue').text



			if game.css('status').attribute('status').text == 'Postponed'
			 	@game_data[number_of_games][:status] = 'Postponed'
			 else

			 	@game_data[number_of_games][:status] = 'F'


				game.css('linescore').each do |score|

					number = 1
			 		@game_data[number_of_games][:score] = {}



					score.css('inning').each do |inn|

						@game_data[number_of_games][:score][number] = {}
						@game_data[number_of_games][:score][number][:away] = {}
						@game_data[number_of_games][:score][number][:home] = {}

						@game_data[number_of_games][:score][number][:away] = inn.attribute('away').text

						if inn.key?('home')

							@game_data[number_of_games][:score][number][:home] = inn.attribute('home').text

						else
							@game_data[number_of_games][:score][number][:home] = '/'
						end
						number +=1
					end

					@game_data[number_of_games][:away_run] = score.css('r').attribute('away').text
					@game_data[number_of_games][:home_run] = score.css('r').attribute('home').text
					@game_data[number_of_games][:away_hit] = score.css('h').attribute('away').text
					@game_data[number_of_games][:home_hit] = score.css('h').attribute('home').text
					@game_data[number_of_games][:away_er] = score.css('e').attribute('away').text
					@game_data[number_of_games][:home_er] = score.css('e').attribute('home').text



					if score.css('hr').empty?
					else

						@game_data[number_of_games][:away_hr] = score.css('hr').attribute('away').text
						@game_data[number_of_games][:home_hr] = score.css('hr').attribute('home').text

					end

					if game.css('linescore hr').empty?
					else

						hr_player = 0

						game.css('home_runs player').each do |hr|
							@game_data[number_of_games][hr_player] = {}
						@game_data[number_of_games][hr_player][:hr_player_name] = hr.attribute('first').text + ' ' + hr.attribute('last').text
						@game_data[number_of_games][hr_player][:hr_player_hr_number] = hr.attribute('hr').text
						@game_data[number_of_games][hr_player][:hr_player_hr_inning] = hr.attribute('inning').text
						hr_player += 1

						end
					end

					if score.css('sb').empty?
						else
							@game_data[number_of_games][:away_sb] = score.css('sb').attribute('away').text
							@game_data[number_of_games][:home_sb] = score.css('sb').attribute('home').text
					end

					if score.css('so').empty?
						else
							@game_data[number_of_games][:away_so] = score.css('so').attribute('away').text
							@game_data[number_of_games][:home_so] = score.css('so').attribute('home').text
					end
				end

				if game.css('winning_pitcher').empty?
				else
					@game_data[number_of_games][:winning_pitcher] = game.css('winning_pitcher').attribute('first').text + " " + game.css('winning_pitcher').attribute('last').text
					@game_data[number_of_games][:winning_pitcher_win] = game.css('winning_pitcher').attribute('wins').text
					@game_data[number_of_games][:winning_pitcher_lose] = game.css('winning_pitcher').attribute('losses').text
					@game_data[number_of_games][:winning_pitcher_era] = game.css('winning_pitcher').attribute('era').text

					@game_data[number_of_games][:losing_pitcher] = game.css('losing_pitcher').attribute('first').text + " " + game.css('losing_pitcher').attribute('last').text
					@game_data[number_of_games][:losing_pitcher_win] = game.css('losing_pitcher').attribute('wins').text
					@game_data[number_of_games][:losing_pitcher_lose] = game.css('losing_pitcher').attribute('losses').text
					@game_data[number_of_games][:losing_pitcher_era] = game.css('losing_pitcher').attribute('era').text
				end


			  if game.css('save_pitcher').attribute('id') == ' '

			  	else
				  	@game_data[number_of_games][:save_pitcher] = game.css('save_pitcher').attribute('first').text + " " + game.css('save_pitcher').attribute('last').text
				  	@game_data[number_of_games][:save_pitcher_win] = game.css('save_pitcher').attribute('wins').text
				  	@game_data[number_of_games][:save_pitcher_lose] = game.css('save_pitcher').attribute('losses').text
				  	@game_data[number_of_games][:save_pitcher_save] = game.css('save_pitcher').attribute('saves').text
				  	@game_data[number_of_games][:save_pitcher_era] = game.css('save_pitcher').attribute('era').text
				  	@game_data[number_of_games][:save_pitcher_svo] = game.css('save_pitcher').attribute('svo').text
				end
			end
			number_of_games += 1
		end
	end
end
