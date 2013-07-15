require 'csv'

class Atbat < ActiveRecord::Base

    self.primary_key = 'game_id_num'

  belongs_to :batter, :foreign_key => 'batter_id'
  belongs_to :pitcher, :foreign_key => 'pitcher_id'
  has_many :pitchings, :foreign_key => 'game_id_num'

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

      url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/inning/inning_all.xml"

      doc = Nokogiri::XML(open(url))

      atbat = doc.css('atbat')


      atbat.each do |atbat|
        @at_bat = {
          game_id: gid,
          num: atbat.attribute('num').text,
          b: atbat.attribute('b').text,
          s: atbat.attribute('s').text,
          o: atbat.attribute('o').text,
          start_tfs: atbat.attribute('start_tfs').text,
          start_tfs_zulu: atbat.attribute('start_tfs_zulu').text,
          batter_id: atbat.attribute('batter').text,
          stand: atbat.attribute('stand').text,
          b_height: atbat.attribute('b_height').text,
          pitcher_id: atbat.attribute('pitcher').text,
          p_throws: atbat.attribute('p_throws').text,
          des: atbat.attribute('des').text,
          event: atbat.attribute('event').text,
          game_id_num: "#{gid}_#{atbat.attribute('num').text}"
        }

        begin
          @atbat = Atbat.where('game_id_num = ?',@atbat[:game_id_num]).first.update_attributes!(@at_bat)
        rescue
          @atbat = Atbat.create(@at_bat)
        end

        begin
          pitcher = @atbat.pitcher
          p_name = pitcher.name_display_first_last
          p_team = pitcher.team_abbrev
        rescue
          p_name = '-'
          p_team = '-'
        end

        begin
          batter = @atbat.batter
          b_name = batter.name_display_first_last
          b_team = batter.team_abbrev
        rescue
          b_name = '-'
          b_team = '-'
        end

        @atbat.update_attributes(
          pitcher_name: p_name,
          pitcher_team: p_team,
          batter_name: b_name,
          batter_team: b_team
          )
      end
    end
  end

  def self.csv
    CSV.open("atbat.csv","wb", headers: true) do |csv|

      att = Atbat.attribute_names
      att.delete('id')
      att.delete('created_at')
      att.delete('updated_at')

      csv << att

      Atbat.find_each do |atbat|
        col = []

        att.each do |att|
          col << "#{atbat[att.to_sym]}"
        end

        csv << col
      end
    end
  end

  def self.seed(gid)
    # gid = '2013_05_19_detmlb_texmlb_1'
      gid = team.game_id
      year = gid.slice(0,4)
      month = gid.slice(5,2)
      day = gid.slice(8,2)
      # 2013/06/01/wasmlb-atlmlb-1
      away_team = gid.slice(11,6)
      home_team = gid.slice(18,6)
      num = gid.slice(25,1)

      url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/inning/inning_all.xml"

      doc = Nokogiri::XML(open(url))

      atbat = doc.css('atbat')


      atbat.each do |atbat|
        @at_bat = {
          game_id: gid,
          num: atbat.attribute('num').text,
          b: atbat.attribute('b').text,
          s: atbat.attribute('s').text,
          o: atbat.attribute('o').text,
          start_tfs: atbat.attribute('start_tfs').text,
          start_tfs_zulu: atbat.attribute('start_tfs_zulu').text,
          batter_id: atbat.attribute('batter').text,
          stand: atbat.attribute('stand').text,
          b_height: atbat.attribute('b_height').text,
          pitcher_id: atbat.attribute('pitcher').text,
          p_throws: atbat.attribute('p_throws').text,
          des: atbat.attribute('des').text,
          event: atbat.attribute('event').text,
          game_id_num: "#{gid}_#{atbat.attribute('num').text}"
        }

        begin
          @atbat = Atbat.where('game_id_num = ?',@atbat[:game_id_num]).first.update_attributes!(@at_bat)
        rescue
          @atbat = Atbat.create(@at_bat)
        end

        begin
          pitcher = @atbat.pitcher
          p_name = pitcher.name_display_first_last
          p_team = pitcher.team_abbrev
        rescue
          p_name = '-'
          p_team = '-'
        end

        begin
          batter = @atbat.batter
          b_name = batter.name_display_first_last
          b_team = batter.team_abbrev
        rescue
          b_name = '-'
          b_team = '-'
        end

        @atbat.update_attributes(
          pitcher_name: p_name,
          pitcher_team: p_team,
          batter_name: b_name,
          batter_team: b_team
          )
      end

  end
end
