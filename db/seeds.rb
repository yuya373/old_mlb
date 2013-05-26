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

Team.delete_all

doc = Nokogiri::XML(open('http://gd2.mlb.com/components/game/mlb/year_2013/month_05/day_07/master_scoreboard.xml'))
game = doc.css('game')
@data = {}
num = 0

game.each do |game|
  @data[num] = {}
  @data[num][:away_team_name] = game.attribute('away_code').text
  @data[num][:home_team_name] = game.attribute('home_code').text
  @data[num][:away_team_id] = game.attribute('away_team_id').text
  @data[num][:home_team_id] = game.attribute('home_team_id').text
  @data[num][:away_league_id] = game.attribute('away_league_id').text
  @data[num][:home_league_id] = game.attribute('home_league_id').text
  @data[num][:away_division] = game.attribute('away_division').text
  @data[num][:home_division] = game.attribute('home_division').text


  Team.create(:name => @data[num][:away_team_name],:team_id =>  @data[num][:away_team_id],:league_id => @data[num][:away_league_id],:division => @data[num][:away_division])
  Team.create(:name => @data[num][:home_team_name],:team_id =>  @data[num][:home_team_id],:league_id => @data[num][:home_league_id],:division => @data[num][:home_division])
  num += 1
end

