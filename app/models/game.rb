require 'open-uri'

class Game < ActiveRecord::Base

  YEAR = 2013
  SEASON = 'regular'

  self.primary_key = 'gameday'
  has_many :line_scores, :foreign_key => 'game_id'
  has_many :benches, :foreign_key => 'game_id'
  has_many :game_batters, :foreign_key => 'game_id'
  has_many :game_pitchers, :foreign_key => 'game_id'
  has_many :atbats, :foreign_key => 'game_id'
  has_many :medias, :foreign_key => 'game_id'
  belongs_to :home_team, :class_name => 'Team', :foreign_key => 'home_team_id'
  belongs_to :away_team, :class_name => 'Team', :foreign_key => 'away_team_id'
  scope  :from_game_id, lambda{|game_id| where('gameday = ?',game_id)}
  scope :y_m_d, lambda{|year,month,day| where('year = ? and month = ? and day = ?',year,month,day)}


  # month[4] = 1.upto(31).to_a
  def self.get_gid(year,hash)
    url = []
    hash.each do |k,v|
      month = sprintf("%.2d",k)
      v.each do |v|
        day = sprintf("%.2d",v)
        url << "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/master_scoreboard.xml"
      end
    end

    game_id = []
    url.each do |url|
      begin
        doc = Nokogiri::XML(open(url))
        doc.css('game').each do |game|
          game_id << game.attribute('gameday').text
        end
      rescue
      end
    end
      return game_id
  end






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

      if num == '2'
        Game.seed("#{year}_#{month}_#{day}_#{away_team}_#{home_team}_1")
      end

      url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/game.xml"

      url2 = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/linescore.xml"
      begin
        doc = Nokogiri::XML(open(url))
        doc2 = Nokogiri::XML(open(url2))

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
        game = doc2.css('game')
        @team = {
                year: year.to_i,
                month: month.to_i,
                day: day.to_i,
                gameday: gid.tr('-','_'),
                home_team_id: home.attribute('id').text,
                home_team_abbrev: home.attribute('abbrev').text,
                home_team_name_full: home.attribute('name_full').text,
                home_team_name: home.attribute('name').text,
                home_team_name_brief: home.attribute('name_brief').text,
                home_w: home.attribute('w').text,
                home_l: home.attribute('l').text,
                home_league_id: home.attribute('league_id').text,
                home_league: home.attribute('league').text,
                away_team_id: away.attribute('id').text,
                away_team_abbrev: away.attribute('abbrev').text,
                away_team_name_full: away.attribute('name_full').text,
                away_team_name: away.attribute('name').text,
                away_team_name_brief: away.attribute('name_brief').text,
                away_w: away.attribute('w').text,
                away_l: away.attribute('l').text,
                away_league_id: away.attribute('league_id').text,
                away_league: away.attribute('league').text,
                stadium: stadium.attribute('name').text,
                location: stadium.attribute('location').text,
                status: game.attribute('status').text,
                # reason: game.attribute('reason').text
                start_time: DateTime.new(year.to_i,month.to_i,day.to_i)
        }

        begin
          Game.where('gameday = ?',@team[:gameday]).first.update_attributes!(@team)
        rescue
          Game.create(@team)
        end
      rescue
      end
    end
  end

  def self.seed(gid)
    year = gid.slice(0,4)
    month = gid.slice(5,2)
    day = gid.slice(8,2)
    # 2013/06/01/wasmlb-atlmlb-1
    away_team = gid.slice(11,6)
    home_team = gid.slice(18,6)
    num = gid.slice(25,1)

    url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/game.xml"

    url2 = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/linescore.xml"
    begin
      doc = Nokogiri::XML(open(url))
      doc2 = Nokogiri::XML(open(url2))
    rescue
    else
      game = doc.css('game')
      if game.attribute('type').text != 'S'

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
        status = doc2.css('game').attribute('status').text
        # reason = doc2.css('game').attribute('reason').text

        @team = {
                year: year.to_i,
                month: month.to_i,
                day: day.to_i,
                gameday: gid.tr('-','_'),
                home_team_id: home.attribute('id').text,
                home_team_abbrev: home.attribute('abbrev').text,
                home_team_name_full: home.attribute('name_full').text,
                home_team_name: home.attribute('name').text,
                home_team_name_brief: home.attribute('name_brief').text,
                home_w: home.attribute('w').text,
                home_l: home.attribute('l').text,
                home_league_id: home.attribute('league_id').text,
                home_league: home.attribute('league').text,
                away_team_id: away.attribute('id').text,
                away_team_abbrev: away.attribute('abbrev').text,
                away_team_name_full: away.attribute('name_full').text,
                away_team_name: away.attribute('name').text,
                away_team_name_brief: away.attribute('name_brief').text,
                away_w: away.attribute('w').text,
                away_l: away.attribute('l').text,
                away_league_id: away.attribute('league_id').text,
                away_league: away.attribute('league').text,
                stadium: stadium.attribute('name').text,
                location: stadium.attribute('location').text,
                status: status,
                start_time: DateTime.new(year.to_i,month.to_i,day.to_i)
                # reason: reason
        }

        begin
          Game.where('gameday = ?',@team[:gameday]).first.update_attributes!(@team)
        rescue
          Game.create(@team)
        end
      else
      end
    end
  end

  def self.csv
    CSV.open("game.csv","wb",headers: true) do |csv|
      att = Game.attribute_names
      att.delete('id')
      att.delete('created_at')
      att.delete('updated_at')

      csv << att

      Game.find_each do |v|
        col = []

        att.each do |att|
          col << "#{v[att.to_sym]}"
        end

        csv << col
      end
    end

  end

end
