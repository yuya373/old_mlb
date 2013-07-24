class PitchersController < ApplicationController

  def index
  end

  def pitcher
    p_id = params[:p_id]
    gid = params[:gid]
    @year = gid.slice(0,4)
    @month = gid.slice(5,2)
    @day = gid.slice(8,2)
    url = build_pitchers_url(gid,p_id)
    doc = Nokogiri::XML(open(url))

    @data = {}
    player = doc.css('Player')

    player.each do |player|
      p_key = player.keys.to_a

      p_key.each do |k|
        v = player.attribute(k).text
        @data[k.to_sym] = v
      end
    end

    @data[:season] = {}
    season = player.css('season')
    season.each do |season|
      s_key = season.keys.to_a
      s_key.each do |k|
        v = season.attribute(k).text
        @data[:season][k.to_sym] = v
      end
    end


    @data[:career] = {}
    career = player.css('career')
    career.each do |career|
      c_key = career.keys.to_a
      c_key.each do |k|
        v = career.attribute(k).text
        @data[:career][k.to_sym] = v
      end
    end

    @data[:month] = {}
    month = player.css('Month')
    month.each do |month|
      m_key = month.keys.to_a
      m_key.each do |k|
        v = month.attribute(k).text
        @data[:month][k.to_sym] = v
      end
    end

    @data[:team] = {}
    team = player.css('Team')
    team.each do |team|
      t_key = team.keys.to_a
      t_key.each do |k|
        v = team.attribute(k).text
        @data[:team][k.to_sym] = v
      end
    end

    @data[:empty] = {}
    empty = player.css('Empty')
    empty.each do |empty|
      e_key = empty.keys.to_a
      e_key.each do |k|
        v = empty.attribute(k).text
        @data[:empty][k.to_sym] = v
      end
    end


    @data[:men_on] = {}
    men_on = player.css('Men_On')
    men_on.each do |men_on|
      m_key = men_on.keys.to_a
      m_key.each do |k|
        v = men_on.attribute(k).text
        @data[:men_on][k.to_sym] = v
      end
    end

    @data[:risp] = {}
    risp = player.css('RISP')
    risp.each do |risp|
      r_key = risp.keys.to_a
      r_key.each do |k|
        v = risp.attribute(k).text
        @data[:risp][k.to_sym] = v
      end
    end

    @data[:loaded] = {}
    loaded = player.css('Loaded')
    loaded.each do |loaded|
      l_key = loaded.keys.to_a
      l_key.each do |k|
        v = loaded.attribute(k).text
        @data[:loaded][k.to_sym] = v
      end
    end

    @data[:vs_lhb] = {}
    vs_lhb = player.css('vs_LHB')
    vs_lhb.each do |vs_lhb|
      key = vs_lhb.keys.to_a
      key.each do |k|
        v = vs_lhb.attribute(k).text
        @data[:vs_lhb][k.to_sym] = v
      end
    end

    @data[:vs_rhb] = {}
    vs_rhb = player.css('vs_RHB')
    vs_rhb.each do |vs_rhb|
      key = vs_rhb.keys.to_a
      key.each do |k|
        v = vs_rhb.attribute(k).text
        @data[:vs_rhb][k.to_sym] = v
      end
    end
  end

  def show
    @p_id = params[:p_id]
    @pitcher = Pitcher.from_p_id(@p_id)

    @pitch_tendencies = @pitcher.pitch_tendencies.where('game_id = ?','last_five').order('num desc')
    @pitch_type = @pitcher.pitch_type_details

    @batter = Atbat.from_pitcher_id(@p_id).for_pitcher

    @atbat = Atbat.from_pitcher_id(params[:pitcher]).from_batter_id(params[:batter]).show

  end

  def r_pitcher(pitcher,item)
    r_pitcher = []
    if item == 'era' || item == 'whip' || item == 'avg' || item == 'slg'
      pitcher.each do |pitcher|
        team_game = pitcher.team.tp_g
        ip = pitcher.ip_sort
        r_pitcher << pitcher if ip >= team_game
      end
    else
      pitcher.each do |pitcher|
        r_pitcher << pitcher
      end
    end
    return r_pitcher
  end

  def all

    @sort = sort('era')
    @item = @sort[0]
    @direction = @sort[1]

    @pitcher = Pitcher.stats(@item,@direction)

    @r_pitcher = r_pitcher(@pitcher,@item)

  end

  def nl
    @sort = sort('era')
    @item = @sort[0]
    @direction = @sort[1]

    @pitcher = Pitcher.stats(@item,@direction).nl

    @r_pitcher = r_pitcher(@pitcher,@item)

    # @nr_pitcher = nr_pitcher(@s_pitcher)

  end

  def al
    @sort = sort('era')
    @item = @sort[0]
    @direction = @sort[1]

    @pitcher = Pitcher.stats(@item,@direction).al

    @r_pitcher = r_pitcher(@pitcher,@item)

    # @nr_pitcher = nr_pitcher(@s_pitcher)

  end

end
