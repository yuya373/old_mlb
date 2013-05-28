# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'rubygems'
require 'Nokogiri'
require 'open-uri'
# Player.delete_all

# team = Team.where("team_id not ?",nil)
# team.each do |t|

#   url = "http://gd2.mlb.com/components/team/stats/#{t.team_id}-stats.xml"
#   doc = Nokogiri::XML(open(url))
#   batter = doc.css('TeamStats batter')
#   batter.each do |b|
#     @batter = {}
#     @batter[:p_id] = b.attribute('id').text
#     @batter[:name] = b.attribute('name').text
#     @batter[:bats] = b.attribute('BATS').text
#     @batter[:throws] = b.attribute('THROWS').text
#     @batter[:pos] =  b.attribute('POS').text
#     @batter[:jersey_number] = b.attribute('JERSEY_NUMBER').text
#     @batter[:team_id] = b.attribute('TEAM_ID').text
#     @batter[:league_id] = b.attribute('LEAGUE_ID').text
#     Player.create(
#       :p_id => @batter[:p_id],
#       :name => @batter[:name],
#       :bats => @batter[:bats],
#       :throws => @batter[:throws],
#       :pos => @batter[:pos],
#       :jersey_number => @batter[:jersey_number],
#       :team_id => @batter[:team_id],
#       :league_id => @batter[:league_id]
#       )
#   end
# end


Team.delete_all

doc = Nokogiri::XML(open('http://gd2.mlb.com/components/game/mlb/year_2013/month_05/day_07/master_scoreboard.xml'))
game = doc.css('game')
@team = {}
num = 0

game.each do |game|
  @team[num] = {}
  @team[num][:away_team_name] = game.attribute('away_code').text
  @team[num][:home_team_name] = game.attribute('home_code').text
  @team[num][:away_team_id] = game.attribute('away_team_id').text
  @team[num][:home_team_id] = game.attribute('home_team_id').text
  @team[num][:away_league_id] = game.attribute('away_league_id').text
  @team[num][:home_league_id] = game.attribute('home_league_id').text
  @team[num][:away_division] = game.attribute('away_division').text
  @team[num][:home_division] = game.attribute('home_division').text
  @team[num][:afname] = game.attribute('away_team_city').text + ' ' +game.attribute('away_team_name').text
  @team[num][:hfname] = game.attribute('home_team_city').text + ' ' +game.attribute('home_team_name').text


  Team.create(
    :name => @team[num][:away_team_name],
    :team_id =>  @team[num][:away_team_id],
    :league_id => @team[num][:away_league_id],
    :division => @team[num][:away_division],
    :fname => @team[num][:afname]
    )
  Team.create(
    :name => @team[num][:home_team_name],
    :team_id =>  @team[num][:home_team_id],
    :league_id => @team[num][:home_league_id],
    :division => @team[num][:home_division],
    :fname => @team[num][:hfname]
    )
  num += 1
end

