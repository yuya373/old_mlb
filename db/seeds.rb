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

def csv_to_team_pitching(file_name)
  pitching = CSV.table(file_name)

  case file_name
  when 'pit_team_pitching.csv'
    team_id = 134
  when 'reds_team_pitching.csv'
    team_id = 113
  end


  pitching.each do |row|
    tp = {
      tp_w: row[:w],
      tp_l: row[:l],
      tp_era: row[:era],
      tp_g: row[:g],
      tp_gs: row[:gs],
      tp_cg: row[:cg],
      tp_sho: row[:sho],
      tp_sv: row[:sv],
      tp_bsv: row[:bs],
      tp_ip: row[:ip],
      tp_h: row[:h],
      tp_r: row[:r],
      tp_er: row[:er],
      tp_hr: row[:hr],
      tp_bb: row[:bb],
      tp_ibb: row[:ibb],
      tp_hb: row[:hbp],
      tp_wp: row[:wp],
      tp_so: row[:so],
      tp_whip: row[:whip]
    }

    Team.where(team_id: team_id).first.update_attributes!(tp)

  end
end

csv_to_team_pitching('pit_team_pitching.csv')









# g_id = Game.get_gid(2013,{'9' => ['18']})

# g_id.each do |gid|
#   Atbat.seed(gid)
#   Pitching.seed(gid)
# end

# CSV.foreach("game_id.csv") do |row|
#   row.each do |gid|
#     Game.seed(gid)
#     GamePitcher.seed(gid)
#     LineScore.seed(gid)
#     Atbat.seed(gid)
#     Media.seed(gid)
#     Media.cg_seed(gid)
#   end
# end


# Game.find_each do |game|
#   year = game.year
#   month = game.month
#   day = game.day

#   st_time = DateTime.new(year,month,day)

#   game.update_attributes(start_time: st_time)
# end



# Team.get
# Game.get
# GameBatter.get
# GamePitcher.get
# Atbat.get
# LineScore.get
# day = 1.upto(31)
# month = 4.upto(7)

# month.each do |month|
#   day.each do |day|
#     day = sprintf("%.2d",day)
#     month = sprintf("%.2d",month)
#     Media.seed('2013',month,day)
#   end
# end

#   Media.seed('2013','03','31')

# Team.where(:team_id => ['110','111','141','139','147','120','121','143','144','146']).each do |team|
#   team.update_attributes(division: 'e')
# end

# Team.where(:team_id => ['114','116','142','118','145','112','113','134','138','158']).each do |team|
#   team.update_attributes(division: 'c')
# end

# Team.where(:team_id => ['108','117','133','136','140','109','115','119','135','137']).each do |team|
#   team.update_attributes(division: 'w')
# end

# Atbat.where('pitcher_name = ? or batter_name = ?','-','-').find_each do |atbat|
#   begin
#     pitcher = atbat.pitcher
#     p_name = pitcher.name_display_first_last
#     p_team = pitcher.team_abbrev
#   rescue
#     p_name = '-'
#     p_team = '-'
#   end

#   begin
#     batter = atbat.batter
#     b_name = batter.name_display_first_last
#     b_team = batter.team_abbrev
#   rescue
#     b_name = '-'
#     b_team = '-'
#   end
#   atbat.update_attributes(
#     pitcher_name: p_name,
#     pitcher_team: p_team,
#     batter_name: b_name,
#     batter_team: b_team
#     )
# end


# CSV.foreach("game_id.csv") do |row|
#   row.each do |gid|
#     LineScore.seed(gid)
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




# CSV.foreach("game_id.csv") do |row|
#   row.each do |gid|
#     Atbat.seed(gid)
#     Game.seed(gid)
#     LineScore.seed(gid)
#     GameBatter.seed(gid)
#     GamePitcher.seed(gid)
#     Media.cg_seed(gid)
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


