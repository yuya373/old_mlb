require 'open-uri'

class Pitching < ActiveRecord::Base


  belongs_to :pitcher, :foreign_key => 'pitcher_id'
  belongs_to :batter, :foreign_key => 'batter_id'
  belongs_to :atbat, :foreign_key => 'game_id_num'

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
        atbat_num = atbat.attribute('num').text
        p = atbat.attribute('pitcher').text
        b = atbat.attribute('batter').text
        num = 0
        atbat.css('pitch').each do |pitch|
          @pitching = {}
          @pitching[:game_id] = gid
          @pitching[:num] = atbat_num
          @pitching[:pitcher_id] = p
          @pitching[:batter_id] = b
          @pitching[:game_id_num] = "#{gid}_#{atbat_num}"
          pitch.keys.to_a.each do |k|
            v = pitch.attribute(k).text
            case k
            when 'id'
            when 'type'
              k = 's_or_ball'
              @pitching[k.to_sym] = v
            else
              @pitching[k.to_sym] = v
            end
          end
            Pitching.create(@pitching)
          num += 1

        end
      end
    end
  end
end
