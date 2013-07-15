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
    @pitcher = Pitcher.where('p_id = ?',@p_id).first

    @pitch_tendencies = @pitcher.pitch_tendencies.where('game_id = ?','last_five').order('num desc')
    @pitch_type = @pitcher.pitch_type_details

    @batter = Atbat.where.not('batter_name = ?','-').where('pitcher_id = ?', @p_id).select('DISTINCT batter_name, batter_id, batter_team').order('batter_name asc')

    @atbat = Atbat.where('pitcher_id = ?',params[:pitcher]).where('batter_id = ?',params[:batter])


  end

  def r_pitcher(pitcher)
    r_pitcher = []
    pitcher.each do |pitcher|
      team_game = pitcher.team.tp_g
      ip = pitcher.ip_sort
      if ip >= team_game
        r_pitcher << pitcher
      end
    end
    return r_pitcher
  end

  def nr_pitcher(pitcher)
    nr_pitcher = []
    pitcher.each do |pitcher|
      team_game = pitcher.team.tp_g
      ip = pitcher.ip_sort
      if ip >= team_game
      else
        nr_pitcher << pitcher
      end
    end
    return nr_pitcher
  end

  def all

    @sort = sort('era')
    @item = @sort[0]
    @direction = @sort[1]

    @pitcher = Pitcher.select('
      p_id,
      team_id,
      team_abbrev,
      name_display_first_last,
      g,
      gs,
      w,
      l,
      hld,
      sv,
      bsv,
      svo,
      ip_sort,
      era_sort,
      whip_sort,
      avg_sort,
      slg_sort,
      so,
      ao,
      go,
      gidp,
      p_inh_runner,
      p_inh_runner_scored,
      cg,
      sho,
      gf,
      np,
      er,
      h,
      r,
      hr,
      hb,
      bb,
      ibb,
      wp,
      tpa,
      ab,
      sf,
      sac,
      pct_sort,
      bk
          ').order(@item + ' ' + @direction)

    @s_pitcher = @pitcher.where('gs > 0')


    @r_pitcher = r_pitcher(@s_pitcher)
    @nr_pitcher = nr_pitcher(@s_pitcher)

    @thead = [
      'Name',
      'Team',
      'w',
      'l',
      'g',
      'gs',
      'hld',
      'sv',
      'bsv',
      'svo',
      'era',
      'ip',
      'whip',
      'avg',
      'slg',
      'so',
      'ao',
      'go',
      'gidp',
      'er',
      'r',
      'h',
      'hr',
      'hb',
      'bb',
      'ibb',
      'wp',
      'bk'
    ]
  end

  def nl
    @sort = sort('era')
    @item = @sort[0]
    @direction = @sort[1]

    @pitcher = Pitcher.where('league_id = 104').select('
      p_id,
      team_id,
      team_abbrev,
      name_display_first_last,
      g,
      gs,
      w,
      l,
      hld,
      sv,
      bsv,
      svo,
      ip_sort,
      era_sort,
      whip_sort,
      avg_sort,
      slg_sort,
      so,
      ao,
      go,
      gidp,
      p_inh_runner,
      p_inh_runner_scored,
      cg,
      sho,
      gf,
      np,
      er,
      h,
      r,
      hr,
      hb,
      bb,
      ibb,
      wp,
      tpa,
      ab,
      sf,
      sac,
      pct_sort,
      bk
          ').order(@item + ' ' + @direction)

    @s_pitcher = @pitcher.where('gs > 0')


    @r_pitcher = r_pitcher(@s_pitcher)
    @nr_pitcher = nr_pitcher(@s_pitcher)

    @thead = [
      'Name',
      'Team',
      'w',
      'l',
      'g',
      'gs',
      'hld',
      'sv',
      'bsv',
      'svo',
      'era',
      'ip',
      'whip',
      'avg',
      'slg',
      'so',
      'ao',
      'go',
      'gidp',
      'er',
      'r',
      'h',
      'hr',
      'hb',
      'bb',
      'ibb',
      'wp',
      'bk'
    ]
  end

  def al
    @sort = sort('era')
    @item = @sort[0]
    @direction = @sort[1]

    @pitcher = Pitcher.where('league_id = 103').select('
      p_id,
      team_id,
      team_abbrev,
      name_display_first_last,
      g,
      gs,
      w,
      l,
      hld,
      sv,
      bsv,
      svo,
      ip_sort,
      era_sort,
      whip_sort,
      avg_sort,
      slg_sort,
      so,
      ao,
      go,
      gidp,
      p_inh_runner,
      p_inh_runner_scored,
      cg,
      sho,
      gf,
      np,
      er,
      h,
      r,
      hr,
      hb,
      bb,
      ibb,
      wp,
      tpa,
      ab,
      sf,
      sac,
      pct_sort,
      bk
          ').order(@item + ' ' + @direction)

    @s_pitcher = @pitcher.where('gs > 0')


    @r_pitcher = r_pitcher(@s_pitcher)
    @nr_pitcher = nr_pitcher(@s_pitcher)

    @thead = [
      'Name',
      'Team',
      'w',
      'l',
      'g',
      'gs',
      'hld',
      'sv',
      'bsv',
      'svo',
      'era',
      'ip',
      'whip',
      'avg',
      'slg',
      'so',
      'ao',
      'go',
      'gidp',
      'er',
      'r',
      'h',
      'hr',
      'hb',
      'bb',
      'ibb',
      'wp',
      'bk'
    ]
  end

end
