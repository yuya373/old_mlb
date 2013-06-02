class Pitcher < ActiveRecord::Base
def self.all_pitcher
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

    @new_pitcher = Pitcher.where('p_id = :p_id', :p_id => @pitcher[number][:p_id]).fitst
    @new_pitcher.update_attributes(@pitcher[number])
    number += 1
    end
end

end
