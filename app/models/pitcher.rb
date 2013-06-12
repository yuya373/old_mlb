require 'open-uri'

class Pitcher < ActiveRecord::Base

  belongs_to :team, :foreign_key => 'team_id'

  def self.all_pitcher
    Team.find_each do |team|
      team_id = team[:team_id]
      gid = team[:game_id]
      url = "http://gd2.mlb.com/components/team/stats/#{team_id}-stats.xml"
      doc = Nokogiri::XML(open(url))

      pitcher = doc.css('TeamStats pitcher')
      pitcher.each do |pitcher|
        @pitcher = {}
        key = pitcher.keys.to_a
        key.each do |k|
          v = pitcher.attribute(k).text
          d_k = k.downcase
          if d_k == 'id'
            d_k = 'p_id'
          end
          @pitcher[d_k.to_sym] = v
        end
        p_id = @pitcher[:p_id]

        year = gid.slice(0,4)
        month = gid.slice(5,2)
        day = gid.slice(8,2)
        # 2013/06/01/wasmlb-atlmlb-1
        away_team = gid.slice(11,6)
        home_team = gid.slice(18,6)
        num = gid.slice(25,1)
        p_url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/pitchers/#{p_id}.xml"
        begin
          data = Nokogiri::XML(open(p_url))
        rescue
          data = nil
        end
        if data == nil
          begin
            Pitcher.where('p_id = ?', p_id).first.update_attributes!(@pitcher)
          rescue
            Pitcher.create(@pitcher)
          end
        else
          player = data.css('Player')
          @pitcher[:height] = player.attribute('height').text
          @pitcher[:weight] = player.attribute('weight').text
          @pitcher[:dob] = player.attribute('dob').text

          career = data.css('career')
          career.each do |career|
            c_key = career.keys.to_a
            c_key.each do |k|
              key = "career_#{k}"
              @pitcher[key.to_sym] = career.attribute(k).text
            end
          end

          month = data.css('month')
          month.each do |month|
            m_key = month.keys.to_a
            m_key.each do |k|
              key = "month_#{k}"
              @pitcher[key.to_sym] = month.attribute(k).text
            end
          end

          empty = data.css('Empty')
          empty.each do |empty|
            e_key = empty.keys.to_a
            e_key.each do |k|
              key = "empty_#{k}"
              @pitcher[key.to_sym] = empty.attribute(k).text
            end
          end

          men_on = data.css('Men_On')
          men_on.each do |men_on|
            mo_key = men_on.keys.to_a
            mo_key.each do |k|
              key = "men_on_#{k}"
              @pitcher[key.to_sym] = men_on.attribute(k).text
            end
          end

          risp = data.css('RISP')
          risp.each do |risp|
            r_key = risp.keys.to_a
            r_key.each do |k|
              key = "risp_#{k}"
              @pitcher[key.to_sym] = risp.attribute(k).text
            end
          end

          loaded = data.css('Loaded')
          loaded.each do |loaded|
            l_key = loaded.keys.to_a
            l_key.each do |k|
              key = "loaded_#{k}"
              @pitcher[key.to_sym] = loaded.attribute(k).text
            end
          end

          vs_lhb = data.css('vs_LHB')
          vs_lhb.each do |vs_lhb|
            lh_key = vs_lhb.keys.to_a
            lh_key.each do |k|
              key = "vs_lhb_#{k}"
              @pitcher[key.to_sym] = vs_lhb.attribute(k).text
            end
          end

          vs_rhb = data.css('vs_RHB')
          vs_rhb.each do |vs_rhb|
            rh_key = vs_rhb.keys.to_a
            rh_key.each do |k|
              key = "vs_rhb_#{k}"
              @pitcher[key.to_sym] = vs_rhb.attribute(k).text
            end
          end

          begin
            Pitcher.where('p_id = ?', p_id).first.update_attributes!(@pitcher)
          rescue
            Pitcher.create(@pitcher)
          end
        end
      end
    end
  end
end
