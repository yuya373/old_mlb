class GamePitcher < ActiveRecord::Base
  belongs_to :game, :foreign_key => 'game_id'

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

      if num == '2'
        GamePitcher.seed("#{year}_#{month}_#{day}_#{away_team}_#{home_team}_1")
      end

      url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/boxscore.xml"
      begin
        doc = Nokogiri::XML(open(url))

        pitching = doc.css('boxscore>pitching')
        pitcher_h = pitching[0].css('pitcher')

        pitcher_h.each do |b|
          @pitcher = {}
          @pitcher[:game_id] = gid.tr('-','_')
          @pitcher[:team_flag] = pitching[0].attribute('team_flag').text
          key = b.keys.to_a
          key.each do |k|
            if k == 'id'
              @pitcher[:p_id] = b.attribute('id').text
            elsif k == 'save'
              @pitcher[:save_] = b.attribute('save').text
            else
              @pitcher[k.to_sym] = b.attribute(k).text
            end
          end

          begin
            GamePitcher.where('game_id = ?',@pitcher[:game_id]).where('p_id = ?',@pitcher[:p_id]).first.update_attributes!(@pitcher)
          rescue
            GamePitcher.create(@pitcher)
          end
        end

        pitcher_a = pitching[1].css('pitcher')

        pitcher_a.each do |b|
          @pitcher = {}
          @pitcher[:game_id] = gid.tr('-','_')
          @pitcher[:team_flag] = pitching[1].attribute('team_flag').text
          key = b.keys.to_a
          key.each do |k|
            if k == 'id'
              @pitcher[:p_id] = b.attribute(k).text
            elsif k == 'save'
              @pitcher[:save_] = b.attribute('save').text
            else
              @pitcher[k.to_sym] = b.attribute(k).text
            end
          end

          begin
            GamePitcher.where('game_id = ?',@pitcher[:game_id]).where('p_id = ?',@pitcher[:p_id]).first.update_attributes!(@pitcher)
          rescue
            GamePitcher.create(@pitcher)
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

    url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/boxscore.xml"
    begin
      doc = Nokogiri::XML(open(url))

      pitching = doc.css('boxscore>pitching')
      pitcher_h = pitching[0].css('pitcher')

      pitcher_h.each do |b|
        @pitcher = {}
        @pitcher[:game_id] = gid.tr('-','_')
        @pitcher[:team_flag] = pitching[0].attribute('team_flag').text
        key = b.keys.to_a
        key.each do |k|
          if k == 'id'
            @pitcher[:p_id] = b.attribute('id').text
          elsif k == 'save'
            @pitcher[:save_] = b.attribute('save').text
          else
            @pitcher[k.to_sym] = b.attribute(k).text
          end
        end

        begin
          GamePitcher.where('game_id = ?',@pitcher[:game_id]).where('p_id = ?',@pitcher[:p_id]).first.update_attributes!(@pitcher)
        rescue
          GamePitcher.create(@pitcher)
        end
      end

      pitcher_a = pitching[1].css('pitcher')

      pitcher_a.each do |b|
        @pitcher = {}
        @pitcher[:game_id] = gid.tr('-','_')
        @pitcher[:team_flag] = pitching[1].attribute('team_flag').text
        key = b.keys.to_a
        key.each do |k|
          if k == 'id'
            @pitcher[:p_id] = b.attribute(k).text
          elsif k == 'save'
            @pitcher[:save_] = b.attribute('save').text
          else
            @pitcher[k.to_sym] = b.attribute(k).text
          end
        end

        begin
          GamePitcher.where('game_id = ?',@pitcher[:game_id]).where('p_id = ?',@pitcher[:p_id]).first.update_attributes!(@pitcher)
        rescue
          GamePitcher.create(@pitcher)
        end
      end
    rescue
    end
  end

  def self.csv
    CSV.open("game_pitcher.csv","wb",headers: true) do |csv|
      att = GamePitcher.attribute_names
      att.delete('id')
      att.delete('created_at')
      att.delete('updated_at')

      csv << att

      GamePitcher.find_each do |v|
        col = []

        att.each do |att|
          col << "#{v[att.to_sym]}"
        end

        csv << col
      end
    end

  end
end
