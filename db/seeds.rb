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

Pitcher.delete_all

 @all_pitcher = Player.where(:pos => "P")
    number = 0
    @pitcher = {}
    @all_pitcher.each do |pitcher|
      @pitcher[number] = {
        p_id: pitcher[:p_id],
        team_id: pitcher[:team_id],
        name: pitcher[:name],
      }

    url = "http://gd2.mlb.com/components/game/mlb/year_2013/pitchers/#{@pitcher[number][:p_id]}.xml"

    doc = Nokogiri::XML(open(url))

    pitching = doc.css('pitching')

    @pitcher[number] = {
      name: pitcher[:name],
      p_id: pitcher[:p_id],
      team_id: pitcher[:team_id],
      era: pitching.attribute('era').text,
      w: pitching.attribute('w').text,
      l: pitching.attribute('l').text,
      whip: pitching.attribute('whip').text,
      ip: pitching.attribute('s_ip').text,
      h: pitching.attribute('s_h').text,
      er: pitching.attribute('s_er').text,
      r: pitching.attribute('s_r').text,
      bb: pitching.attribute('s_bb').text,
      k: pitching.attribute('s_k').text,
      sv: pitching.attribute('s_sv').text,
      hbp: pitching.attribute('s_hbp').text,
      hra: pitching.attribute('s_hra').text
    }

    Pitcher.create(@pitcher[number])
    number += 1
    end



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

#         Batter.create(
#           name: @batter[number][:name],
#           p_id: @batter[number][:p_id],
#           team_id: @batter[number][:team_id],
#           avg: @batter[number][:avg],
#           ab: @batter[number][:ab],
#           h: @batter[number][:h],
#           r: @batter[number][:r],
#           rbi: @batter[number][:rbi],
#           single: @batter[number][:single],
#           double: @batter[number][:double],
#           triple: @batter[number][:triple],
#           hr: @batter[number][:hr],
#           bb: @batter[number][:bb],
#           hbp: @batter[number][:hbp],
#           sb: @batter[number][:sb],
#           cs: @batter[number][:cs],
#           so: @batter[number][:so],
#           err: @batter[number][:err])

#         number += 1
#       end
#     end

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

