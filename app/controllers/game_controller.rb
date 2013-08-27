class GameController < ApplicationController
  def test
    @games = Game.where('year = ? and month = ?', params[:year], params[:month])
  end
  def index
    if params[:date]
      @note = true
      @year = params[:date][:year]
      @month = params[:date][:month]
      @day = params[:date][:day]

      @game = Game.y_m_d(@year,@month,@day)
    else
      @note = nil
    end
  end

  def show
    @g_id = params[:g_id]
    @game = Game.from_game_id(@g_id).first
  end

  def atbat
    @g_id = params[:g_id]
    @game = Game.from_game_id(@g_id).first
    @atbat = @game.atbats
    @inning = @atbat.select('distinct inning')
    @num = []
    @inning.each do |inn|
      @num << inn.inning
    end

    @data = {}
    @num.each do |num|
      @data[num] = {}
      top_atbat = @atbat.where('inning = ?',num).where('t_b = ?','top')
      bot_atbat = @atbat.where('inning = ?',num).where('t_b = ?','bottom')
      @data[num][:top] = top_atbat
      @data[num][:bot] = bot_atbat
    end


  end

  def highlight
    @g_id = params[:g_id]
    @media = Media.where(game_id: @g_id).order(:sv_id).where.not(media_type: 'condensed')
    @cg = Media.where('game_id = ? and media_type = ?', @g_id, 'condensed')
  end

  def get_gid
    date = Date.yesterday
    # .yesterday
    year = date.year
    month =  sprintf("%.2d",date.month)
    day =  sprintf("%.2d",date.day)
    url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/master_scoreboard.xml"

    doc = Nokogiri::XML(open(url))

    game = doc.css('game')

    gid = []

    game.each do |game|
      gid << game.attribute('gameday').text
    end

    return gid
  end


  def today_index
    @gid = get_gid
    @game = {}


    @gid.each do |gid|
      @game[gid] = {}
      # gid = '2013_05_19_detmlb_texmlb_1'
      year = gid.slice(0,4)
      month = gid.slice(5,2)
      day = gid.slice(8,2)
      away_team = gid.slice(11,6)
      home_team = gid.slice(18,6)
      num = gid.slice(25,1)


      url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/linescore.xml"

      doc = Nokogiri::XML(open(url))

      game = doc.css('game')
      line_score = doc.css('game>linescore')

      @node = game.first.attributes
      @node.each do |k,v|
        @game[gid][k.to_sym] = v.text
      end

      @game[gid][:line_score] = {}

      line_score.each do |line|
        @game[gid][:line_score][line.attribute('inning').text] = {}
        @game[gid][:line_score][line.attribute('inning').text] = {
          home_inning_runs: line.attribute('home_inning_runs').text,
          away_inning_runs: line.attribute('away_inning_runs').text
        }
      end

      if @game[gid][:ind] == 'F'
        win = game.css('game>winning_pitcher').first.attributes
        @game[gid][:winning_pitcher] = {}
        win.each do |k,v|
          @game[gid][:winning_pitcher][k.to_sym] = v.text
        end

        lose = game.css('game>losing_pitcher').first.attributes
        @game[gid][:losing_pitcher] = {}
        lose.each do |k,v|
          @game[gid][:losing_pitcher][k.to_sym] = v.text
        end

        save = game.css('game>save_pitcher').first.attributes
        @game[gid][:save_pitcher] = {}
        save.each do |k,v|
          @game[gid][:save_pitcher][k.to_sym] = v.text
        end
      end

      if @game[gid][:ind] == 'S'
        home_pitcher = game.css('home_probable_pitcher').first.attributes
        @game[gid][:home_probable_pitcher] = {}

        home_pitcher.each do |k,v|
          @game[gid][:home_probable_pitcher][k.to_sym] = v.text
        end

        away_pitcher = game.css('away_probable_pitcher').first.attributes
        @game[gid][:away_probable_pitcher] = {}

        away_pitcher.each do |k,v|
          @game[gid][:away_probable_pitcher][k.to_sym] = v.text
        end

        if @game[:ind] == 'I'
        end

      end

    end
  end

  def today_show
    @game = {}
    gid = params[:g_id]
    year = gid.slice(0,4)
    month = gid.slice(5,2)
    day = gid.slice(8,2)
    away_team = gid.slice(11,6)
    home_team = gid.slice(18,6)
    num = gid.slice(25,1)


    url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/boxscore.xml"

    doc = Nokogiri::XML(open(url))

    box = doc.css('boxscore')
    line = box.css('linescore')
    inning = line.css('inning_line_score')
    pitching = box.css('pitching')
    pitcher = pitching.css('pitcher')
    batting = box.css('batting')
    batter = batting.css('batter')

    box.first.attributes.each do |k,v|
      @game[k.to_sym] = v.text
    end

    @game[:linescore] = {}
    line.first.attributes.each do |k,v|
      @game[:linescore][k.to_sym] = v.text
    end

    @game[:linescore][:inning] = {}
    inning.each do |inn|
      num = inn.attribute('inning').text
      @game[:linescore][:inning][num] = {
        away: inn.attribute('away').text,
        home: inn.attribute('home').text
      }
    end

    @pitching = {}

    pitching.each do |pitch|
        if pitch.attribute('team_flag').text == 'away'
          @pitching[:away] = {}
          pitch.attributes.each do |k,v|
            @pitching[:away][k.to_sym] = v.text
          end

          away_pitchers = []
          pitch.css('pitcher').each do |pitcher|
            hash = {}
            pitcher.attributes.each do |k,v|
              hash[k.to_sym] = v.text
            end
            away_pitchers << hash
          end

          @pitching[:away][:pitchers] = away_pitchers

        else
          @pitching[:home] = {}
          pitch.attributes.each do |k,v|
            @pitching[:home][k.to_sym] = v.text
          end

          home_pitchers = []
          pitch.css('pitcher').each do |pitcher|
            hash = {}
            pitcher.attributes.each do |k,v|
              hash[k.to_sym] = v.text
            end
            home_pitchers << hash
          end

          @pitching[:home][:pitchers] = home_pitchers
        end
    end

    @batting = {}

    batting.each do |bat|
      if bat.attribute('team_flag').text == 'away'
        @batting[:away] = {}
        bat.attributes.each do |k,v|
          @batting[:away][k.to_sym] = v.text
        end

        away_batters = []
        bat.css('batter').each do |batter|
          hash = {}
          batter.attributes.each do |k,v|
            hash[k.to_sym] = v.text
          end
          away_batters << hash
        end
        @batting[:away][:batters] = away_batters

      else
        @batting[:home] = {}
        bat.attributes.each do |k,v|
          @batting[:home][k.to_sym] = v.text
        end

        home_batters = []
        bat.css('batter').each do |batter|
          hash = {}
          batter.attributes.each do |k,v|
            hash[k.to_sym] = v.text
          end
          home_batters << hash
        end
        @batting[:home][:batters] = home_batters
      end
    end
  end

end
