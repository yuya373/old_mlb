class LineScore < ActiveRecord::Base

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

      url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/linescore.xml"

      doc = Nokogiri::XML(open(url))

      game = doc.css('game')
      line = game.css('linescore')

      line.each do |line|
        @score = {
          game_id: gid,
          inning: line.attribute('inning').text,
          home: line.attribute('home_inning_runs').text,
          away: line.attribute('away_inning_runs').text,
          home_team_runs: game.attribute('home_team_runs').text,
          away_team_runs: game.attribute('away_team_runs').text,
          home_team_hits: game.attribute('home_team_hits').text,
          away_team_hits: game.attribute('away_team_hits').text,
          home_team_errors: game.attribute('home_team_errors').text,
          away_team_errors: game.attribute('away_team_errors').text
        }
        begin
          LineScore.where('game_id = ?',@score[:game_id]).where('inning = ?',@score[:inning]).first.update_attributes!(@score)
        rescue
          LineScore.create(@score)
        end
      end
    end
  end
end
