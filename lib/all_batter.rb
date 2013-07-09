require 'open-uri'

class AllBatter
  def self.all_batter
     @al_batter = Player.where("p_id not ?", nil)
    number = 0
    @batter = {}
    @al_batter.each do |batter|
      @batter[number] = {}
      if batter[:pos] == 'P'
      else
        @batter[number][:p_id] = batter[:p_id]
        @batter[number][:team_id] = batter[:team_id]
        @batter[number][:name] = batter[:name]


        url = "http://gd2.mlb.com/components/game/mlb/year_2013/batters/#{@batter[number][:p_id]}.xml"
        doc = Nokogiri::XML(open(url))
        batting = doc.css('batting')
        @batter[number] = {
          name: batter[:name],
          p_id: batter[:p_id],
          team_id: batter[:team_id],
          avg: batting.attribute('avg').text,
          ab: batting.attribute('s_ab').text,
          h: batting.attribute('s_h').text,
          r: batting.attribute('s_r').text,
          rbi: batting.attribute('s_rbi').text,
          single: batting.attribute('s_single').text,
          double: batting.attribute('s_double').text,
          triple: batting.attribute('s_triple').text,
          hr: batting.attribute('s_hr').text,
          bb: batting.attribute('s_bb').text,
          hbp: batting.attribute('s_hbp').text,
          sb: batting.attribute('s_sb').text,
          cs: batting.attribute('s_cs').text,
          so: batting.attribute('s_so').text,
          err: batting.attribute('s_err').text
        }

        @new_batter = Batter.where('p_id = :p_id',{:p_id => @batter[number][:p_id]}).first

        @new_batter.update_attributes(@batter[number])
        number += 1
      end
    end
  end
end
