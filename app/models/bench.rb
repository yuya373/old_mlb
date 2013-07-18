class Bench < ActiveRecord::Base
  belongs_to :game, :foreign_key => 'gameday'
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

      url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/players.xml"
      begin
        doc = Nokogiri::XML(open(url))



        if doc.css('team')[0].attribute('type').text == 'home'
          home = doc.css('team')[0]
        else
          away = doc.css('team')[0]
        end

        if doc.css('team')[1].attribute('type').text == 'away'
          away = doc.css('team')[1]
        else
          home = doc.css('team')[1]
        end

        h_p = home.css('player')
        h_p.each do |p|
          @player = {
            game_id: gid,
            team: 'home',
            p_id: p.attribute('id').text
          }

          begin
            Bench.where('game_id = ?',@player[:game_id]).where('p_id = ?',@player[:p_id]).first.update_attributes!(@player)
          rescue
            Bench.create(@player)
          end
        end

        a_p = away.css('player')
        a_p.each do |p|
          @player = {
            game_id: gid,
            team: away.attribute('name').text,
            p_id: p.attribute('id').text
          }

          begin
            Bench.where('game_id = ?',@player[:game_id]).where('p_id = ?',@player[:p_id]).first.update_attributes!(@player)
          rescue
            Bench.create(@player)
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

    url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/players.xml"

    doc = Nokogiri::XML(open(url))



    if doc.css('team')[0].attribute('type').text == 'home'
      home = doc.css('team')[0]
    else
      away = doc.css('team')[0]
    end

    if doc.css('team')[1].attribute('type').text == 'away'
      away = doc.css('team')[1]
    else
      home = doc.css('team')[1]
    end

    h_p = home.css('player')
    h_p.each do |p|
      @player = {
        game_id: gid,
        team: home.attribute('name').text,
        p_id: p.attribute('id').text
      }

      begin
        Bench.where('game_id = ?',@player[:game_id]).where('p_id = ?',@player[:p_id]).first.update_attributes!(@player)
      rescue
        Bench.create(@player)
      end
    end

    a_p = away.css('player')
    a_p.each do |p|
      @player = {
        game_id: gid,
        team: away.attribute('name').text,
        p_id: p.attribute('id').text
      }

      begin
        Bench.where('game_id = ?',@player[:game_id]).where('p_id = ?',@player[:p_id]).first.update_attributes!(@player)
      rescue
        Bench.create(@player)
      end
    end
  end

  def self.csv
    CSV.open("bench.csv","wb",headers: true) do |csv|
      att = Bench.attribute_names
      att.delete('id')
      att.delete('created_at')
      att.delete('updated_at')

      csv << att

      Bench.find_each do |v|
        col = []

        att.each do |att|
          col << "#{v[att.to_sym]}"
        end

        csv << col
      end
    end

  end
end
