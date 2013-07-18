class LineScore < ActiveRecord::Base

  belongs_to :game, :foreign_key => 'game_id'
  def self.csv
    CSV.open("line_score.csv","wb",headers: true) do |csv|
      att = LineScore.attribute_names
      att.delete('id')
      att.delete('created_at')
      att.delete('updated_at')

      csv << att

      LineScore.find_each do |v|
        col = []

        att.each do |att|
          col << "#{v[att.to_sym]}"
        end

        csv << col
      end
    end

  end

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
      begin
        doc = Nokogiri::XML(open(url))

        game = doc.css('game')
        line = game.css('linescore')
        wp = game.css('winning_pitcher')
        lp = game.css('losing_pitcher')
        sv = game.css('save_pitcher')

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
            away_team_errors: game.attribute('away_team_errors').text,
            wp_id: wp.attribute('id').text,
            wp_name: "#{wp.attribute('first').text} #{wp.attribute('last').text}",
            wp_w: wp.attribute('wins').text,
            wp_l: wp.attribute('losses').text,
            wp_era: wp.attribute('era').text,
            lp_id: lp.attribute('id').text,
            lp_name: "#{lp.attribute('first').text} #{lp.attribute('last').text}",
            lp_w: lp.attribute('wins').text,
            lp_l: lp.attribute('losses').text,
            lp_era: lp.attribute('era').text,
            sv_id: sv.attribute('id').text,
            sv_name: "#{sv.attribute('first').text} #{sv.attribute('last').text}",
            sv_w: sv.attribute('wins').text,
            sv_l: sv.attribute('losses').text,
            sv_era: sv.attribute('era').text,
            sv_sv: sv.attribute('saves').text

          }
          begin
            LineScore.where('game_id = ?',@score[:game_id]).where('inning = ?',@score[:inning]).first.update_attributes!(@score)
          rescue
            LineScore.create(@score)
          end
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

      url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/linescore.xml"

      doc = Nokogiri::XML(open(url))

      game = doc.css('game')
      line = game.css('linescore')
      wp = game.css('winning_pitcher')
      lp = game.css('losing_pitcher')
      sv = game.css('save_pitcher')

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
          away_team_errors: game.attribute('away_team_errors').text,
          wp_id: wp.attribute('id').text,
          wp_name: "#{wp.attribute('first').text} #{wp.attribute('last').text}",
          wp_w: wp.attribute('wins').text,
          wp_l: wp.attribute('losses').text,
          wp_era: wp.attribute('era').text,
          lp_id: lp.attribute('id').text,
          lp_name: "#{lp.attribute('first').text} #{lp.attribute('last').text}",
          lp_w: lp.attribute('wins').text,
          lp_l: lp.attribute('losses').text,
          lp_era: lp.attribute('era').text,
          sv_id: sv.attribute('id').text,
          sv_name: "#{sv.attribute('first').text} #{sv.attribute('last').text}",
          sv_w: sv.attribute('wins').text,
          sv_l: sv.attribute('losses').text,
          sv_era: sv.attribute('era').text,
          sv_sv: sv.attribute('saves').text
        }
        begin
          LineScore.where('game_id = ?',@score[:game_id]).where('inning = ?',@score[:inning]).first.update_attributes!(@score)
        rescue
          LineScore.create(@score)
        end
      end
    end
end
