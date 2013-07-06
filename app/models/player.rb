require 'open-uri'

class Player < ActiveRecord::Base


  def self.update
    Team.find_each do |t|

      url = "http://gd2.mlb.com/components/team/stats/#{t.team_id]}-stats.xml"
      doc = Nokogiri::XML(open(url))
      batter = doc.css('TeamStats batter')
      game = doc.css('TeamStats')
      batter.each do |b|
        @batter = {
          p_id: b.attribute('id').text,
          name: b.attribute('name').text,
          bats: b.attribute('BATS').text,
          throws: b.attribute('THROWS').text,
          pos: b.attribute('POS').text,
          jersey_number: b.attribute('JERSEY_NUMBER').text,
          team_id: b.attribute('TEAM_ID').text,
          league_id: b.attribute('LEAGUE_ID').text,
          game: game.children[0].attribute('G').text
        }
          p_id = @batter[:p_id]
        begin
          Player.where(['p_id = ?', p_id]).first.update_attributes!(@batter)
        rescue
          Player.create(@batter)
        end

        # @old_player.update_attributes(@batter[num])
      end
    end
  end
end
