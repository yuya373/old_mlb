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

# Team.all.each do |team|
#   gid = team.game_id.tr('/','_')
#   team.update_attribute(:game_id, gid)

# end

# g_id = [
# '2013/07/14/anamlb-seamlb-1',
# '2013/07/14/milmlb-arimlb-1',
# '2013/07/14/tormlb-balmlb-1',
# '2013/07/14/bosmlb-oakmlb-1',
# '2013/07/14/slnmlb-chnmlb-1',
# '2013/07/14/cinmlb-atlmlb-1',
# '2013/07/14/kcamlb-clemlb-1',
# '2013/07/14/colmlb-lanmlb-1',
# '2013/07/14/texmlb-detmlb-1',
# '2013/07/14/houmlb-tbamlb-1',
# '2013/07/14/wasmlb-miamlb-1',
# '2013/07/14/nynmlb-pitmlb-1',
# '2013/07/14/sfnmlb-sdnmlb-1',
# '2013/07/14/minmlb-nyamlb-1',
# '2013/07/14/chamlb-phimlb-1',
# '2013/07/12/anamlb-seamlb-1',
# '2013/07/12/milmlb-arimlb-1',
# '2013/07/12/tormlb-balmlb-1',
# '2013/07/12/bosmlb-oakmlb-1',
# '2013/07/12/slnmlb-chnmlb-1',
# '2013/07/12/cinmlb-atlmlb-1',
# '2013/07/12/kcamlb-clemlb-1',
# '2013/07/12/colmlb-lanmlb-1',
# '2013/07/12/texmlb-detmlb-1',
# '2013/07/12/houmlb-tbamlb-1',
# '2013/07/12/wasmlb-miamlb-1',
# '2013/07/12/nynmlb-pitmlb-1',
# '2013/07/12/sfnmlb-sdnmlb-1',
# '2013/07/12/minmlb-nyamlb-1',
# '2013/07/13/anamlb-seamlb-1',
# '2013/07/13/milmlb-arimlb-1',
# '2013/07/13/tormlb-balmlb-1',
# '2013/07/13/bosmlb-oakmlb-1',
# '2013/07/13/slnmlb-chnmlb-1',
# '2013/07/13/cinmlb-atlmlb-1',
# '2013/07/13/kcamlb-clemlb-1',
# '2013/07/13/colmlb-lanmlb-1',
# '2013/07/13/texmlb-detmlb-1',
# '2013/07/13/houmlb-tbamlb-1',
# '2013/07/13/wasmlb-miamlb-1',
# '2013/07/13/nynmlb-pitmlb-1',
# '2013/07/13/sfnmlb-sdnmlb-1',
# '2013/07/13/minmlb-nyamlb-1',
# '2013/07/13/chamlb-phimlb-2',
# '2013_07_11_bosmlb_seamlb_1',
# '2013_07_11_chamlb_detmlb_1',
# '2013_07_11_cinmlb_atlmlb_1',
# '2013_07_11_colmlb_lanmlb_1',
# '2013_07_11_kcamlb_nyamlb_1',
# '2013_07_11_milmlb_arimlb_1',
# '2013_07_11_minmlb_tbamlb_1',
# '2013_07_11_sfnmlb_sdnmlb_1',
# '2013_07_11_slnmlb_chnmlb_1',
# '2013_07_11_texmlb_balmlb_1',
# '2013_07_11_tormlb_clemlb_1',
# '2013_07_11_wasmlb_phimlb_1']

g_id = [
'2013_07_11_bosmlb_seamlb_1',
'2013_07_11_chamlb_detmlb_1',
'2013_07_11_cinmlb_atlmlb_1',
'2013_07_11_colmlb_lanmlb_1',
'2013_07_11_kcamlb_nyamlb_1',
'2013_07_11_milmlb_arimlb_1',
'2013_07_11_minmlb_tbamlb_1',
'2013_07_11_sfnmlb_sdnmlb_1',
'2013_07_11_slnmlb_chnmlb_1',
'2013_07_11_texmlb_balmlb_1',
'2013_07_11_tormlb_clemlb_1',
'2013_07_11_wasmlb_phimlb_1']


g_id.each do |gid|
  t_gid = gid.tr('_','/')
  # Atbat.where('game_id = ?',gid).delete_all
  Pitching.where('game_id = ?',t_gid).delete_all
end

# g_id.each do |gid|
#   t_gid = gid.tr('/','_')
#   Atbat.seed(t_gid)
#   Pitching.seed(t_gid)
# end


# game_id = []

# num_7 = 11.upto(14).to_a
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
#   # Atbat.seed(gid)
#   # Bench.seed(gid)
#   # Game.seed(gid)
#   # GameBatter.seed(gid)
#   # GamePitcher.seed(gid)
#   # LineScore.seed(gid)
#   # PitchTendency.seed(gid)
#   # Pitching.seed(gid)

#   PitchTypeDetail.seed_pitcher(gid)
#   PitchTypeDetail.seed_batter(gid)

# end


# atbat = CSV.table("db/atbat.csv")
# atbat_att = atbat.headers
# atbat.each do |row|
#   @atbat = {}
#   atbat_att.each do |att|
#     @atbat[att.to_sym] = row[att]
#   end
#   begin
#     @atbat = Atbat.where('game_id_num = ?',@atbat[:game_id_num]).first.update_attributes!(@at_bat)
#   rescue
#     @atbat = Atbat.create(@at_bat)
#   end
# end

# bench = CSV.table("db/bench.csv")
# bench_att = bench.headers
# bench.each do |row|
#   @bench = {}
#   bench_att.each do |att|
#     @bench[att.to_sym] = row[att]
#   end
#   begin
#     Bench.where('game_id = ?',@bench[:game_id]).where('p_id = ?',@bench[:p_id]).first.update_attributes!(@bench)
#   rescue
#     Bench.create(@bench)
#   end
# end


# game = CSV.table("db/game.csv")
# game_att = game.headers
# game.each do |row|
#   @game = {}
#   game_att.each do |att|
#     @game[att.to_sym] = row[att]
#   end
#   begin
#     Game.where('game_id = ?',@game[:game_id]).first.update_attributes!(@game)
#   rescue
#     Game.create(@game)
#   end

# end

# game_batter = CSV.table("db/game_batter.csv")
# game_batter_att = game_batter.headers
# game_batter.each do |row|
#   @game_batter = {}
#   game_batter_att.each do |att|
#     @game_batter[att.to_sym] = row[att]
#   end
#   begin
#     GameBatter.where('game_id = ?',@game_batter[:game_id]).where('p_id = ?',@game_batter[:p_id]).first.update_attributes!(@game_batter)
#   rescue
#     GameBatter.create(@game_batter)
#   end
# end


# game_pitcher = CSV.table("db/game_pitcher.csv")
# game_pitcher_att = game_pitcher.headers
# game_pitcher.each do |row|
#   @game_pitcher = {}
#   game_pitcher_att.each do |att|
#     @game_pitcher[att.to_sym] = row[att]
#   end
#   begin
#     GamePitcher.where('game_id = ?',@game_pitcher[:game_id]).where('p_id = ?',@game_pitcher[:p_id]).first.update_attributes!(@game_pitcher)
#   rescue
#     GamePitcher.create(@game_pitcher)
#   end
# end

# linescore = CSV.table("db/line_score.csv")
# linescore_att = linescore.headers
# linescore.each do |row|
#   @linescore = {}
#   linescore_att.each do |att|
#     @linescore[att.to_sym] = row[att]
#   end
#   begin
#     LineScore.where('game_id = ?',@linescore[:game_id]).where('inning = ?',@linescore[:inning]).first.update_attributes!(@linescore)
#   rescue
#     LineScore.create(@linescore)
#   end
# end

# pitch_tendency = CSV.table("db/pitch_tendency.csv")
# pitch_tendency_att = pitch_tendency.headers
# pitch_tendency.each do |row|
#   @pitch_tendency = {}
#   pitch_tendency_att.each do |att|
#     @pitch_tendency[att.to_sym] = row[att]
#   end
#   begin
#     PitchTendency.where('game_id = ?', @pitch_tendency[:game_id]).where('p_id = ?', @pitch_tendency[:p_id]).where('pitch_type = ?',@pitch_tendency[:pitch_type]).first.update_attributes!(@pitch_tendency)
#   rescue
#     PitchTendency.create(@pitch_tendency)
#   end
# end

# pitch_type_detail = CSV.table("db/pitch_type_detail.csv")
# pitch_type_detail_att = pitch_type_detail.headers
# pitch_type_detail.each do |row|
#   @pitch_type_detail = {}
#   pitch_type_detail_att.each do |att|
#     @pitch_type_detail[att.to_sym] = row[att]
#   end
#   begin
#     PitchTypeDetail.where('p_id_ty = ?',@pitch_type_detail[:p_id_ty]).where('p_b = ?',@pitch_type_detail[:p_b]).first.update_attributes!(@pitch_type_detail)
#   rescue
#     PitchTypeDetail.create(@pitch_type_detail)
#   end
# end

# pitching = CSV.table("db/pitching1.csv")
# pitching_att = pitching.headers
# pitching.each do |row|
#   @pitching = {}
#   pitching_att.each do |att|
#     @pitching[att.to_sym] = row[att]
#   end
#   begin
#     Pitching.where('sv_id = ?', @pitching[:sv_id]).first.update_attributes!(@pitching)
#   rescue
#     Pitching.create(@pitching)
#   end
# end

# pitching = CSV.table("db/pitching2.csv")
# pitching_att = pitching.headers
# pitching.each do |row|
#   @pitching = {}
#   pitching_att.each do |att|
#     @pitching[att.to_sym] = row[att]
#   end
#   begin
#     Pitching.where('sv_id = ?', @pitching[:sv_id]).first.update_attributes!(@pitching)
#   rescue
#     Pitching.create(@pitching)
#   end
# end



# Atbat.csv
# Bench.csv
# Game.csv
# GameBatter.csv
# GamePitcher.csv
# LineScore.csv
# PitchTendency.csv
# PitchTypeDetail.csv
# Pitching.csv

#7月11日から14日までのデータ
# db削除→dbに保存→csvに変換→sakuraに保存

# Atbat.delete_all
# Bench.delete_all
# Game.delete_all
# GameBatter.delete_all
# GamePitcher.delete_all
# LineScore.delete_all
# PitchTendency.delete_all
# PitchTypeDetail.delete_all
# Pitching.delete_all


# game_id = []

# num_7 = 11.upto(14).to_a
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
#   # Atbat.seed(gid)
#   # Bench.seed(gid)
#   # Game.seed(gid)
#   # GameBatter.seed(gid)
#   # GamePitcher.seed(gid)
#   # LineScore.seed(gid)
#   # PitchTendency.seed(gid)
#   # Pitching.seed(gid)

#   PitchTypeDetail.seed_pitcher(gid)
#   PitchTypeDetail.seed_batter(gid)

# end

# url = {}
# game_id.each do |gid|

#       year = gid.slice(0,4)
#       month = gid.slice(5,2)
#       day = gid.slice(8,2)
#       # 2013/06/01/wasmlb-atlmlb-1
#       away_team = gid.slice(11,6)
#       home_team = gid.slice(18,6)
#       num = gid.slice(25,1)

#       u = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/inning/inning_all.xml"

#       url[gid] = u
# end


#     url.each do |gid,url|
#       begin
#         doc = Nokogiri::XML(open(url))

#         atbat = doc.css('atbat')


#         atbat.each do |atbat|
#           @at_bat = {
#             game_id: gid,
#             num: atbat.attribute('num').text,
#             b: atbat.attribute('b').text,
#             s: atbat.attribute('s').text,
#             o: atbat.attribute('o').text,
#             start_tfs: atbat.attribute('start_tfs').text,
#             start_tfs_zulu: atbat.attribute('start_tfs_zulu').text,
#             batter_id: atbat.attribute('batter').text,
#             stand: atbat.attribute('stand').text,
#             b_height: atbat.attribute('b_height').text,
#             pitcher_id: atbat.attribute('pitcher').text,
#             p_throws: atbat.attribute('p_throws').text,
#             des: atbat.attribute('des').text,
#             event: atbat.attribute('event').text,
#             game_id_num: "#{gid}_#{atbat.attribute('num').text}"
#           }

#           begin
#             @atbat = Atbat.where('game_id_num = ?',@atbat[:game_id_num]).first.update_attributes!(@at_bat)
#           rescue
#             @atbat = Atbat.create(@at_bat)
#           end
#         end
#       rescue
#       end
#     end

#       Atbat.find_each do |atbat|
#         begin
#           pitcher = atbat.pitcher
#           p_name = pitcher.name_display_first_last
#           p_team = pitcher.team_abbrev
#         rescue
#           p_name = '-'
#           p_team = '-'
#         end

#         begin
#           batter = atbat.batter
#           b_name = batter.name_display_first_last
#           b_team = batter.team_abbrev
#         rescue
#           b_name = '-'
#           b_team = '-'
#         end

#         atbat.update_attributes(
#           pitcher_name: p_name,
#           pitcher_team: p_team,
#           batter_name: b_name,
#           batter_team: b_team
#           )
#       end




# url.each do |gid,url|

#   # Pitchings
#   begin
#     doc = Nokogiri::XML(open(url))
#     inning = doc.css('inning')
#     top = inning.css('top')
#     bot = inning.css('bottom')
#     top_atbat = top.css('atbat')
#     bot_atbat = bot.css('atbat')

#     top_atbat.each do |atbat|
#       atbat_num = atbat.attribute('num').text
#       p = atbat.attribute('pitcher').text
#       b = atbat.attribute('batter').text
#       atbat.css('pitch').each do |pitch|
#         @pitching = {}
#         @pitching[:inning] = 'top'
#         @pitching[:inning_num] = inning.attribute('num').text
#         @pitching[:away_team] = inning.attribute('away_team').text
#         @pitching[:home_team] = inning.attribute('home_team').text

#         @pitching[:game_id] = gid
#         @pitching[:num] = atbat_num
#         @pitching[:pitcher_id] = p
#         @pitching[:batter_id] = b
#         @pitching[:game_id_num] = "#{gid}_#{atbat_num}"
#         pitch.keys.to_a.each do |k|
#           v = pitch.attribute(k).text
#           case k
#           when 'id'
#           when 'type'
#             k = 's_or_ball'
#             @pitching[k.to_sym] = v
#           else
#             @pitching[k.to_sym] = v
#           end
#         end
#         begin
#           Pitching.where('sv_id = ?', @pitching[:sv_id]).first.update_attributes!(@pitching)
#         rescue
#           Pitching.create(@pitching)
#         end
#       end
#     end

#     bot_atbat.each do |atbat|
#       atbat_num = atbat.attribute('num').text
#       p = atbat.attribute('pitcher').text
#       b = atbat.attribute('batter').text
#       atbat.css('pitch').each do |pitch|
#         @pitching = {}
#         @pitching[:inning] = 'bot'
#         @pitching[:inning_num] = inning.attribute('num').text
#         @pitching[:away_team] = inning.attribute('away_team').text
#         @pitching[:home_team] = inning.attribute('home_team').text

#         @pitching[:game_id] = gid
#         @pitching[:num] = atbat_num
#         @pitching[:pitcher_id] = p
#         @pitching[:batter_id] = b
#         @pitching[:game_id_num] = "#{gid}_#{atbat_num}"
#         pitch.keys.to_a.each do |k|
#           v = pitch.attribute(k).text
#           case k
#           when 'id'
#           when 'type'
#             k = 's_or_ball'
#             @pitching[k.to_sym] = v
#           else
#             @pitching[k.to_sym] = v
#           end
#         end
#         begin
#           Pitching.where('sv_id = ?', @pitching[:sv_id]).first.update_attributes!(@pitching)
#         rescue
#           Pitching.create(@pitching)
#         end
#       end
#     end
#   rescue
#   end

# end




# Atbat.find_each do |atbat|
#   begin
#     @p_name = atbat.pitcher.name_display_first_last
#     @p_team = atbat.pitcher.team_abbrev
#   rescue
#     @p_team = '-'
#     @p_name = '-'
#   end

#   begin
#     @b_name = atbat.batter.name_display_first_last
#     @b_team = atbat.batter.team_abbrev
#   rescue
#     @b_team = '-'
#     @b_name = '-'
#   end

#   atbat.update_attributes(
#     pitcher_team: @p_team,
#     pitcher_name: @p_name,
#     batter_name: @b_naem,
#     batter_team: @_team
#     )
# end




# pt_url = {}
# game_id.each do |gid|

#       # 2013/06/01/wasmlb-atlmlb-1
#       year = gid.slice(0,4)
#       month = gid.slice(5,2)
#       day = gid.slice(8,2)
#       away_team = gid.slice(11,6)
#       home_team = gid.slice(18,6)
#       num = gid.slice(25,1)
#       url1 = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/premium/pitchers/"

#       begin
#         doc = Nokogiri::XML(open(url1)).css('a')

#         p_id = []

#         doc.each do |doc|
#           p_id << doc.attribute('href').text
#         end

#         p_id.delete_at(0)

#         p_id.each do |p_id|
#           url2 = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/premium/pitchers/#{p_id}pitchtendencies_history.xml"
#           pt_url[p_id.to_sym] = url2
#         end
#       rescue
#       end
# end
#       pt_url.each do |k,v|
#         begin
#           pt = Nokogiri::XML(open(v))
#           lf = pt.css('last_five')
#           @pt_lf = {
#             p_id: k.slice(0,6),
#             game_id: 'last_five',
#             game_num: lf.attribute('num').text,
#             game_vel: lf.attribute('vel').text
#           }
#           lf.css('type').each do |ty|
#             ty.keys.to_a.each do |k|
#               if k == 'id'
#                 @pt_lf[:pitch_type] = ty.attribute('id').text
#               else
#                 @pt_lf[k.to_sym] = ty.attribute(k).text
#               end
#             end
#             begin
#               PitchTendency.where('game_id = ?', @pt_lf[:game_id]).where('p_id = ?', @pt_lf[:p_id]).where('pitch_type = ?',@pt_lf[:pitch_type]).first.update_attributes!(@pt_lf)
#             rescue
#               PitchTendency.create(@pt_lf)
#             end
#           end

#           game = pt.css('game')
#           game.each do |game|
#             @pt_g = {
#               p_id: k.slice(0,6),
#               game_id: game.attribute('id').text,
#               game_num: game.attribute('num').text,
#               game_vel: game.attribute('vel').text
#             }

#             game.css('type').each do |ty|
#               ty.keys.to_a.each do |k|
#                 if k == 'id'
#                   @pt_g[:pitch_type] = ty.attribute('id').text
#                 else
#                   @pt_g[k.to_sym] = ty.attribute(k).text
#                 end
#               end
#               begin
#                 PitchTendency.where('game_id = ?', @pt_g[:game_id]).where('p_id = ?', @pt_g[:p_id]).where('pitch_type = ?',@pt_g[:pitch_type]).first.update_attributes!(@pt_g)
#               rescue
#                 PitchTendency.create(@pt_g)
#               end
#             end
#           end
#         rescue
#         end
#       end




# PitchTypeDetail.where('p_b = ?', 'p').each do |b|
#   p_id = b.p_id
#   pitch_type = b.pitch_type.slice(1,2)

#   b.update_attributes(p_id_ty: "#{p_id}_#{pitch_type}", pitch_type: pitch_type)
# end

# num = 1.upto(30).to_a
# game_id = []
# num.each do |num|
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
# url = {}
# game_id.each do |gid|

#   # gid = '2013_05_19_detmlb_texmlb_1'
#   year = gid.slice(0,4)
#   month = gid.slice(5,2)
#   day = gid.slice(8,2)
#   # 2013/06/01/wasmlb-atlmlb-1
#   away_team = gid.slice(11,6)
#   home_team = gid.slice(18,6)
#   num = gid.slice(25,1)

#   p_id_url = "http://gd2.mlb.com/components/game/mlb/year_2013/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/premium/pitchers/"
#     begin
#       doc = Nokogiri::XML(open(p_id_url)).css('a')

#       p_id = []

#       doc.each do |doc|
#         p_id << doc.attribute('href').text
#       end

#       p_id.delete_at(0)

#       pitch_type = [
#         'pch',
#         'pcu',
#         'pfa',
#         'pfc',
#         'pff',
#         'pfs',
#         'pft',
#         'pkn',
#         'psi',
#         'psl'
#       ]

#       p_id.each do |p_id|
#         ary = []
#         pitch_type.each do |ty|
#           aaa = "http://gd2.mlb.com/components/game/mlb/year_2013/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/premium/pitchers/#{p_id}#{ty}.xml"

#           # url = "http://gd2.mlb.com/components/game/mlb/year_2013/month_06/day_28/gid_2013_06_28_wasmlb_nynmlb_1/premium/batters/150029/#{ty}.xml"

#           ary << aaa

#           url[p_id.to_sym] = ary

#         end
#       end
#     rescue
#     end
# end



#       url.each do |k,v|
#         v.each do |v|
#           doc2 = Nokogiri::XML(open(v))
#           sit = doc2.css('sit')
#           cont = {
#             p_b: 'p',
#             p_id: k.slice(0,6),
#             p_id_ty: "#{k.slice(0,6)}_#{v.to_s.slice(120,3)}",
#             pitch_type: v.to_s.slice(120,3),
#             ab: sit.attribute('ab').text,
#             avg: sit.attribute('avg').text,
#             hr: sit.attribute('hr').text,
#             rbi: sit.attribute('rbi').text,
#             bb: sit.attribute('bb').text,
#             so: sit.attribute('so').text,
#             ops: sit.attribute('ops').text,
#             rating: sit.attribute('rating').text,
#             sweetness: sit.attribute('sweetness').text
#           }
#           begin
#             PitchTypeDetail.where('p_id_ty = ?',cont[:p_id_ty]).first.update_attributes!(cont)
#           rescue
#             PitchTypeDetail.create(cont)
#           end
#         end
#       end





# num = 1.upto(10).to_a
# game_id = []
# num.each do |num|
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

# game_id.each do |gid|

#   # gid = '2013_05_19_detmlb_texmlb_1'
#   year = gid.slice(0,4)
#   month = gid.slice(5,2)
#   day = gid.slice(8,2)
#   # 2013/06/01/wasmlb-atlmlb-1
#   away_team = gid.slice(11,6)
#   home_team = gid.slice(18,6)
#   num = gid.slice(25,1)


#   url = "http://gd2.mlb.com/components/game/mlb/year_2013/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/premium/batters/"
#   begin
#     doc = Nokogiri::XML(open(url)).css('a')
#     p_id = []

#     doc.each do |doc|
#       p_id << doc.attribute('href').text
#     end


#     pitch_type = [
#       'pch',
#       'pcu',
#       'pfa',
#       'pfc',
#       'pff',
#       'pfs',
#       'pft',
#       'pkn',
#       'psi',
#       'psl'
#     ]


#     p_id.each do |p_id|
#       pitch_type.each do |ty|
#         url = "http://gd2.mlb.com/components/game/mlb/year_2013/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/premium/batters/#{p_id}#{ty}.xml"
#         begin
#           sit = Nokogiri::XML(open(url)).css('sit')
#           cont = {
#             p_id: p_id.slice(0,6),
#             p_id_ty: "#{p_id.slice(0,6)}_#{ty}",
#             pitch_type: ty,
#             ab: sit.attribute('ab').text,
#             avg: sit.attribute('avg').text,
#             hr: sit.attribute('hr').text,
#             rbi: sit.attribute('rbi').text,
#             bb: sit.attribute('bb').text,
#             so: sit.attribute('so').text,
#             ops: sit.attribute('ops').text,
#             rating: sit.attribute('rating').text,
#             sweetness: sit.attribute('sweetness').text
#           }

#           begin
#             BatterDetail.where('p_id_ty = ?',cont[:p_id_ty]).first.update_attributes!(cont)
#           rescue
#             BatterDetail.create(cont)
#           end
#         rescue
#           next
#         end
#       end
#     end
#   rescue
#     next
#   end
# end


# Team.all.each do |team|
#   win = team.tp_w.to_f
#   game = team.tp_g.to_f
#   win_pct = win/game
#   team.update_attribute(:win_pct, win_pct)
# end

# Pitching.find_each do |p|
#   num = p.num
#   game_id = p.game_id
#   p.update_attribute(:game_id_num,"#{game_id}_#{num}")
# end

# Atbat.find_each do |atbat|
#   num = atbat.num
#   game_id = atbat.game_id
#   @new = {game_id_num: "#{game_id}_#{num}"}
#   atbat.update_attribute(:game_id_num,"#{game_id}_#{num}")
# end


# num = 1.upto(31).to_a
# game_id = []
# num.each do |num|
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

# game_id.each do |gid|

#   # gid = '2013_05_19_detmlb_texmlb_1'
#   year = gid.slice(0,4)
#   month = gid.slice(5,2)
#   day = gid.slice(8,2)
#   # 2013/06/01/wasmlb-atlmlb-1
#   away_team = gid.slice(11,6)
#   home_team = gid.slice(18,6)
#   num = gid.slice(25,1)

#   url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/inning/inning_all.xml"
#   begin
#     doc = Nokogiri::XML(open(url))

#     atbat = doc.css('atbat')
#     atbat.each do |atbat|
#         atbat_num = atbat.attribute('num').text
#         p = atbat.attribute('pitcher').text
#         b = atbat.attribute('batter').text
#         atbat.css('pitch').each do |pitch|
#           @pitching = {}
#           @pitching[:game_id] = gid
#           @pitching[:num] = atbat_num
#           @pitching[:pitcher_id] = p
#           @pitching[:batter_id] = b
#           pitch.keys.to_a.each do |k|
#             v = pitch.attribute(k).text
#             case k
#             when 'id'
#             when 'type'
#               k = 's_or_ball'
#               @pitching[k.to_sym] = v
#             else
#               @pitching[k.to_sym] = v
#             end
#           end
#             Pitching.create(@pitching)
#         end
#       end
#   rescue
#       next
#   end
# end


# team = Team.where("team_id not ?", nil)
#     team.each do |t|

#       url = "http://gd2.mlb.com/components/team/stats/#{t[:team_id]}-stats.xml"
#       doc = Nokogiri::XML(open(url))
#       batter = doc.css('TeamStats batter')
#       game = doc.css('TeamStats')
#       batter.each do |b|
#         @batter = {}
#         @batter[:p_id] = b.attribute('id').text
#         @batter[:name] = b.attribute('name').text
#         @batter[:bats] = b.attribute('BATS').text
#         @batter[:throws] = b.attribute('THROWS').text
#         @batter[:pos] =  b.attribute('POS').text
#         @batter[:jersey_number] = b.attribute('JERSEY_NUMBER').text
#         @batter[:team_id] = b.attribute('TEAM_ID').text
#         @batter[:league_id] = b.attribute('LEAGUE_ID').text
#         @batter[:game] = game.children[0].attribute('G').text
#         @old_player = Player.where('p_id = :p_id', {:p_id => @batter[:p_id]}).first

#         @old_player.update_attributes(@batter)
#       end
#     end

# Pitcher.delete_all

#  @all_pitcher = Player.where(:pos => "P")
#     number = 0
#     @pitcher = {}
#     @all_pitcher.each do |pitcher|
#       @pitcher[number] = {
#         p_id: pitcher[:p_id],
#         team_id: pitcher[:team_id],
#         name: pitcher[:name],
#       }

#     url = "http://gd2.mlb.com/components/game/mlb/year_2013/pitchers/#{@pitcher[number][:p_id]}.xml"

#     doc = Nokogiri::XML(open(url))

#     pitching = doc.css('pitching')

#     @pitcher[number] = {
#       name: pitcher[:name],
#       p_id: pitcher[:p_id],
#       team_id: pitcher[:team_id],
#       league_id: pitcher[:league_id],
#       era: pitching.attribute('era').text,
#       w: pitching.attribute('w').text,
#       l: pitching.attribute('l').text,
#       whip: pitching.attribute('whip').text,
#       ip: pitching.attribute('s_ip').text,
#       h: pitching.attribute('s_h').text,
#       er: pitching.attribute('s_er').text,
#       r: pitching.attribute('s_r').text,
#       bb: pitching.attribute('s_bb').text,
#       k: pitching.attribute('s_k').text,
#       sv: pitching.attribute('s_sv').text,
#       hbp: pitching.attribute('s_hbp').text,
#       hra: pitching.attribute('s_hra').text
#     }

#     Pitcher.create(@pitcher[number])
#     number += 1
#     end



# Batter.delete_all

# @al_batter = Player.where("p_id not ?", nil)
#     number = 0
#     @batter = {}
#     @al_batter.each do |batter|
#       @batter[number] = {}
#       if batter[:pos] == 'P'
#       else
#         @batter[number][:p_id] = batter[:p_id]
#         @batter[number][:team_id] = batter[:team_id]
#         @batter[number][:name] = batter[:name]


#         url = "http://gd2.mlb.com/components/game/mlb/year_2013/batters/#{@batter[number][:p_id]}.xml"
#         doc = Nokogiri::XML(open(url))
#         batting = doc.css('batting')
#         @batter[number] = {
#           name: batter[:name],
#           p_id: batter[:p_id],
#           team_id: batter[:team_id],
#           league_id: batter[:league_id],
#           game: batter[:game],
#           avg: batting.attribute('avg').text,
#           ab: batting.attribute('s_ab').text,
#           h: batting.attribute('s_h').text,
#           r: batting.attribute('s_r').text,
#           rbi: batting.attribute('s_rbi').text,
#           single: batting.attribute('s_single').text,
#           double: batting.attribute('s_double').text,
#           triple: batting.attribute('s_triple').text,
#           hr: batting.attribute('s_hr').text,
#           bb: batting.attribute('s_bb').text,
#           hbp: batting.attribute('s_hbp').text,
#           sb: batting.attribute('s_sb').text,
#           cs: batting.attribute('s_cs').text,
#           so: batting.attribute('s_so').text,
#           err: batting.attribute('s_err').text
#         }

#         Batter.create(@batter[number])

#         number += 1
#       end
#     end

# Player.delete_all

# team = Team.where("team_id not ?", nil)
# team.each do |t|

#   url = "http://gd2.mlb.com/components/team/stats/#{t[:team_id]}-stats.xml"
#   doc = Nokogiri::XML(open(url))
#   batter = doc.css('TeamStats batter')
#   game = doc.css('TeamStats')
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
#     @batter[:game] = game.children[0].attribute('G').text
#     Player.create(@batter)
#   end

  # pitcher = doc.css('TeamStats pitcher')
  # pitcher.each do |p|
  #   @pitcher = {}
  # end
# end


# Team.delete_all

# doc = Nokogiri::XML(open('http://gd2.mlb.com/components/game/mlb/year_2013/month_05/day_07/master_scoreboard.xml'))
# game = doc.css('game')
# @team = {}
# num = 0

# game.each do |game|
#   @team[num] = {}
#   @team[num][:away_team_name] = game.attribute('away_code').text
#   @team[num][:home_team_name] = game.attribute('home_code').text
#   @team[num][:away_team_id] = game.attribute('away_team_id').text
#   @team[num][:home_team_id] = game.attribute('home_team_id').text
#   @team[num][:away_league_id] = game.attribute('away_league_id').text
#   @team[num][:home_league_id] = game.attribute('home_league_id').text
#   @team[num][:away_division] = game.attribute('away_division').text
#   @team[num][:home_division] = game.attribute('home_division').text
#   @team[num][:afname] = game.attribute('away_team_city').text + ' ' +game.attribute('away_team_name').text
#   @team[num][:hfname] = game.attribute('home_team_city').text + ' ' +game.attribute('home_team_name').text


#   Team.create(
#     :name => @team[num][:away_team_name],
#     :team_id =>  @team[num][:away_team_id],
#     :league_id => @team[num][:away_league_id],
#     :division => @team[num][:away_division],
#     :fname => @team[num][:afname]
#     )
#   Team.create(
#     :name => @team[num][:home_team_name],
#     :team_id =>  @team[num][:home_team_id],
#     :league_id => @team[num][:home_league_id],
#     :division => @team[num][:home_division],
#     :fname => @team[num][:hfname]
#     )
#   num += 1
# end

