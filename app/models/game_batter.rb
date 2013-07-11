require "open-uri"

class GameBatter < ActiveRecord::Base

  def self.get
    Team.find_each do |team|
      gid = team.game_id
      year = gid.slice(0,4)
      month = gid.slice(5,2)
      day = gid.slice(8,2)
      # 2013/06/01/wasmlb-atlmlb-1
      away_team = gid.slice(11,6)
      home_team = gid.slice(18,6)
      num = gid.slice(25,1)

      url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/boxscore.xml"

      doc = Nokogiri::XML(open(url))

      batting = doc.css('boxscore>batting')
      batter_h = batting[0].css('batter')

      batter_h.each do |b|
        @batter = {}
        @batter[:game_id] = gid
        @batter[:team_flag] = batting[0].attribute('team_flag').text
        key = b.keys.to_a
        key.each do |k|
          if k == 'id'
            @batter[:p_id] = b.attribute('id').text
          else
            @batter[k.to_sym] = b.attribute(k).text
          end
        end

        begin
          GameBatter.where('game_id = ?',@batter[:game_id]).where('p_id = ?',@batter[:p_id]).first.update_attributes!(@batter)
        rescue
          GameBatter.create(@batter)
        end
      end

      batter_a = batting[1].css('batter')

      batter_a.each do |b|
        @batter = {}
        @batter[:game_id] = gid
        @batter[:team_flag] = batting[1].attribute('team_flag').text
        key = b.keys.to_a
        key.each do |k|
          if k == 'id'
            @batter[:p_id] = b.attribute(k).text
          else
            @batter[k.to_sym] = b.attribute(k).text
          end
        end

        begin
          GameBatter.where('game_id = ?',@batter[:game_id]).where('p_id = ?',@batter[:p_id]).first.update_attributes!(@batter)
        rescue
          GameBatter.create(@batter)
        end
      end
    end
  end
end
