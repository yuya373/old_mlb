require 'open-uri'

class MasterScoreboardController < ApplicationController



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
	end
end
