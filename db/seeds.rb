# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'


CSV.foreach("game_id.csv") do |row|
  row.each do |gid|
    Atbat.seed(gid)
  end
end





# game_id = []

#   url = "http://gd2.mlb.com/components/game/mlb/year_2013/month_03/day_31/master_scoreboard.xml"
#   begin
#     doc = Nokogiri::XML(open(url))
#     doc.css('game').each do |game|
#       game_id << game.attribute('gameday').text
#     end
#   rescue
#   end

# num_4 = 1.upto(30).to_a
# num_4.each do |num|
#   day = sprintf("%.2d",num)
#   url = "http://gd2.mlb.com/components/game/mlb/year_2013/month_04/day_#{day}/master_scoreboard.xml"
#   begin
#     doc = Nokogiri::XML(open(url))
#     doc.css('game').each do |game|
#       game_id << game.attribute('gameday').text
#     end
#   rescue
#     next
#   end
# end

# num_5 = 1.upto(31).to_a
# num_5.each do |num|
#   day = sprintf("%.2d",num)
#   url = "http://gd2.mlb.com/components/game/mlb/year_2013/month_05/day_#{day}/master_scoreboard.xml"
#   begin
#     doc = Nokogiri::XML(open(url))
#     doc.css('game').each do |game|
#       game_id << game.attribute('gameday').text
#     end
#   rescue
#     next
#   end
# end

# num_6 = 1.upto(30).to_a
# num_6.each do |num|
#   day = sprintf("%.2d",num)
#   url = "http://gd2.mlb.com/components/game/mlb/year_2013/month_06/day_#{day}/master_scoreboard.xml"
#   begin
#     doc = Nokogiri::XML(open(url))
#     doc.css('game').each do |game|
#       game_id << game.attribute('gameday').text
#     end
#   rescue
#     next
#   end
# end

# num_7 = 1.upto(14).to_a
# num_7.each do |num|
#   day = sprintf("%.2d",num)
#   url = "http://gd2.mlb.com/components/game/mlb/year_2013/month_07/day_#{day}/master_scoreboard.xml"
#   begin
#     doc = Nokogiri::XML(open(url))
#     doc.css('game').each do |game|
#       game_id << game.attribute('gameday').text
#     end
#   rescue
#     next
#   end
# end

# game_id.each do |gid|
#   gid.tr('/','_')
#   Atbat.seed(gid)
  # Pitching.seed(gid)
  # Game.seed(gid)
  # GamePitcher.seed(gid)
  # GameBatter.seed(gid)
  # LineScore.seed(gid)
# end


