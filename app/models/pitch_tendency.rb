require 'open-uri'

class PitchTendency < ActiveRecord::Base

  belongs_to :pitcher, :foreign_key => 'p_id'

  def self.get

    Team.find_each do |team|
      gid = team.game_id

      # 2013/06/01/wasmlb-atlmlb-1
      year = gid.slice(0,4)
      month = gid.slice(5,2)
      day = gid.slice(8,2)
      away_team = gid.slice(11,6)
      home_team = gid.slice(18,6)
      num = gid.slice(25,1)
      url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/premium/pitchers/"

      doc = Nokogiri::XML(open(url)).css('a')

      p_id = []

      doc.each do |doc|
        p_id << doc.attribute('href').text
      end

      p_id.delete_at(0)

      p_id.each do |p_id|
        url2 = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/premium/pitchers/#{p_id}pitchtendencies_history.xml"

        pt = Nokogiri::XML(open(url2))
        lf = pt.css('last_five')
        @pt_lf = {
          p_id: p_id.slice(0,6),
          game_id: 'last_five',
          game_num: lf.attribute('num').text,
          game_vel: lf.attribute('vel').text
        }
        lf.css('type').each do |ty|
          ty.keys.to_a.each do |k|
            if k == 'id'
              @pt_lf[:pitch_type] = ty.attribute('id').text
            else
              @pt_lf[k.to_sym] = ty.attribute(k).text
            end
          end
          begin
            PitchTendency.where('game_id = ?', @pt_lf[:game_id]).where('p_id = ?', @pt_lf[:p_id]).where('pitch_type = ?',@pt_lf[:pitch_type]).first.update_attributes!(@pt_lf)
          rescue
            PitchTendency.create(@pt_lf)
          end
        end

        game = pt.css('game')
        game.each do |game|
          @pt_g = {
            p_id: p_id.slice(0,6),
            game_id: game.attribute('id').text,
            game_num: game.attribute('num').text,
            game_vel: game.attribute('vel').text
          }

          game.css('type').each do |ty|
            ty.keys.to_a.each do |k|
              if k == 'id'
                @pt_g[:pitch_type] = ty.attribute('id').text
              else
                @pt_g[k.to_sym] = ty.attribute(k).text
              end
            end
            begin
              PitchTendency.where('game_id = ?', @pt_g[:game_id]).where('p_id = ?', @pt_g[:p_id]).where('pitch_type = ?',@pt_g[:pitch_type]).first.update_attributes!(@pt_g)
            rescue
              PitchTendency.create(@pt_g)
            end
          end
        end
      end
    end
  end



end
