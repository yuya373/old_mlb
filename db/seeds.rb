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

Atbat.delete_all
PitchTendency.delete_all

PitchTendency.seed('2013_07_19_oakmlb-anamlb-1')
Atbat.seed('2013_07_19_oakmlb-anamlb-1')

# CSV.foreach("game_id.csv") do |row|
#   row.each do |gid|
#     Atbat.seed(gid)
#   end
# end

# Pitching.delete_all
# Atbat.where('game_id like ?',"2013/07/14%").delete_all

# Team.get
# Batter.get
# Pitcher.get
# Pitching.get
# Atbat.get
# PitchTypeDetail.batter_get
# PitchTypeDetail.pitcher_get
# PitchTendency.get
# Bench.get
# Game.get
# GameBatter.get
# GamePitcher.get
# LineScore.get

# game_id = [
# '2013_07_19_oakmlb-anamlb-1',
# '2013_07_19_chnmlb-colmlb-1',
# '2013_07_19_balmlb-texmlb-1',
# '2013_07_19_arimlb-sfnmlb-1',
# '2013_07_19_nyamlb-bosmlb-1',
# '2013_07_19_clemlb-minmlb-1',
# '2013_07_19_pitmlb-cinmlb-1',
# '2013_07_19_detmlb-kcamlb-1',
# '2013_07_19_seamlb-houmlb-1',
# '2013_07_19_lanmlb-wasmlb-1',
# '2013_07_19_phimlb-nynmlb-1',
# '2013_07_19_sdnmlb-slnmlb-1',
# '2013_07_19_tbamlb-tormlb-1',
# '2013_07_19_atlmlb-chamlb-1',
# '2013_07_19_miamlb-milmlb-1'
# ]

# game_id.each do |gid|
#   Pitching.seed(gid)
#     Atbat.seed(gid)
# end




# Atbat.where('game_id_num like ?',"2013_07_19%").delete_all

# game_id = [
#   '2013_07_04_sfnmlb_cinmlb_1',
#   '2013_07_04_chamlb_phimlb_1',
#   '2013_06_06_nynmlb_wasmlb_1',
#   '2013_06_18_lanmlb_nyamlb_1',
#   '2013_05_19_tormlb_nyamlb_1',
#   '2013_05_29_arimlb_texmlb_1',
#   '2013_05_31_sfnmlb_slnmlb_1',
#   '2013_04_10_nyamlb_clemlb_1',
#   '2013_04_11_nyamlb_clemlb_1',
#   '2013_04_17_anamlb_minmlb_1',
#   '2013_04_19_lanmlb_balmlb_1',
#   '2013_04_26_clemlb_kcamlb_1',
#   '2013_04_23_kcamlb_detmlb_1']

#   game_id.each do |gid|
#     Atbat.seed(gid)
#   end




# CSV.foreach("gameid_7.csv") do |row|
#   row.each do |gid|
#     # Pitching.seed(gid)
#     Atbat.seed(gid)
#   end
# end


 # Game.seed('2013_04_19_slnmlb_phimlb_1')
 # LineScore.seed('2013_04_19_slnmlb_phimlb_1')




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


