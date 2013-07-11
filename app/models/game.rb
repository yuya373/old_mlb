require 'open-uri'

class Game < ActiveRecord::Base

  def self.get
    Team.find_each do |team|
      # gid = '2013_05_19_detmlb_texmlb_1'
      gid = team.game_id
      year = gid.slice(0,4)
      month = gid.slice(5,2)
      day = gid.slice(8,2)
      # 2013/06/01/wasmlb-atlmlb-1
      away_team = gid.slice(11,6)
      home_team = gid.slice(18,6)
      num = gid.slice(25,1)

      url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/game.xml"

      doc = Nokogiri::XML(open(url))

      @team = {}
      if doc.css('team')[0].attribute('type').text == 'home'
        home = doc.css('team')[0]
      else
        away = doc.css('team')[0]
      end

      if doc.css('team')[1].attribute('type').text == 'away'
        away = doc.css('team')[1]
      else
        home = doc.css('team')[1]
      end

      stadium = doc.css('stadium')

      @team = {
              game_id: gid,
              home_team_abbrev: home.attribute('abbrev').text,
              home_team_name_full: home.attribute('name_full').text,
              home_team_name: home.attribute('name').text,
              home_team_name_brief: home.attribute('name_brief').text,
              home_w: home.attribute('w').text,
              home_l: home.attribute('l').text,
              home_league_id: home.attribute('league_id').text,
              home_league: home.attribute('league').text,
              away_team_abbrev: away.attribute('abbrev').text,
              away_team_name_full: away.attribute('name_full').text,
              away_team_name: away.attribute('name').text,
              away_team_name_brief: away.attribute('name_brief').text,
              away_w: away.attribute('w').text,
              away_l: away.attribute('l').text,
              away_league_id: away.attribute('league_id').text,
              away_league: away.attribute('league').text,
              stadium: stadium.attribute('name').text,
              location: stadium.attribute('location').text
      }

      begin
        Game.where('game_id = ?',@team[:game_id]).first.update_attributes!(@team)
      rescue
        Game.create(@team)
      end

    end

  end
end