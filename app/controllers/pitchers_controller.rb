class PitchersController < ApplicationController
  after_filter :flush, only: [:all, :al, :nl]

  def flush
    flash.now[:update] = when_updated(@pitcher.first)
  end



  def show
    @p_id = params[:p_id]
    @pitcher = Pitcher.from_p_id(@p_id)

    @pitch_tendencies = @pitcher.pitch_tendencies.where('game_id = ?','last_five').order('num desc')
    @pitch_type = @pitcher.pitch_type_details

    @batter = {}
    @team = []
    @pitcher.atbats.select('distinct batter_team').each do |atbat|
      @team << atbat.batter_team
      @batter[atbat.batter_team] = []
    end
      @team.each do |v|
        @pitcher.atbats.where.not('batter_name = ?', '-').where('batter_team = ?',v).for_pitcher.each do |bat|
          @batter[v] << [bat.batter_name,bat.batter_id]
        end
      end


    @atbat = Atbat.from_pitcher_id(params[:pitcher]).from_batter_id(params[:batter]).show
    flash[:update] = when_updated(@pitcher)

  end


  def split
    @p_id = params[:p_id]
    @pitcher = Pitcher.from_p_id(@p_id)

    @pitch_tendencies = @pitcher.pitch_tendencies.where('game_id = ?','last_five').order('num desc')
    @pitch_type = @pitcher.pitch_type_details
  end

  def vs_batter
    @p_id = params[:p_id]
    @pitcher = Pitcher.from_p_id(@p_id)

    @batter = {}
    @team = []
    @pitcher.atbats.select('distinct batter_team').each do |atbat|
      @team << atbat.batter_team
      @batter[atbat.batter_team] = []
    end
      @team.each do |v|
        @pitcher.atbats.where.not('batter_name = ?', '-').where('batter_team = ?',v).for_pitcher.each do |bat|
          @batter[v] << [bat.batter_name,bat.batter_id]
        end
      end


    @atbat = Atbat.from_pitcher_id(params[:pitcher]).from_batter_id(params[:batter]).show
  end

  def highlight
    @p_id = params[:p_id]
    @pitcher = Pitcher.from_p_id(@p_id)

    @media = @pitcher.medias
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

  def leaders
    @leaders = {
      era: Pitcher.sp_leaders_pct('era',10),
      w: Pitcher.sp_leaders('w',10),
      so: Pitcher.sp_leaders('so',10),
      hld: Pitcher.leaders('hld',10),
      sv: Pitcher.leaders('sv',10),
      bsv: Pitcher.leaders('bsv',10),
      ip: Pitcher.sp_leaders('ip',10),
      np: Pitcher.sp_leaders('np',10),
      hr: Pitcher.leaders('hr',10),
      avg: Pitcher.sp_leaders_pct('avg',10),
      slg: Pitcher.sp_leaders_pct('slg',10),
      whip: Pitcher.sp_leaders_pct('whip',10),
      ao: Pitcher.sp_leaders('ao',10),
      go: Pitcher.sp_leaders('go',10),
      gidp: Pitcher.sp_leaders('gidp',10),
      ab: Pitcher.sp_leaders('ab',10),
      cg: Pitcher.sp_leaders('cg',10),
      sho: Pitcher.sp_leaders('sho',10)
    }
  end

  def al_leaders
    @leaders = {
      era: Pitcher.al.sp_leaders_pct('era',10),
      w: Pitcher.al.sp_leaders('w',10),
      so: Pitcher.al.sp_leaders('so',10),
      hld: Pitcher.al.leaders('hld',10),
      sv: Pitcher.al.leaders('sv',10),
      bsv: Pitcher.al.leaders('bsv',10),
      ip: Pitcher.al.sp_leaders('ip',10),
      np: Pitcher.al.sp_leaders('np',10),
      hr: Pitcher.al.leaders('hr',10),
      avg: Pitcher.al.sp_leaders_pct('avg',10),
      slg: Pitcher.al.sp_leaders_pct('slg',10),
      whip: Pitcher.al.sp_leaders_pct('whip',10),
      ao: Pitcher.al.sp_leaders('ao',10),
      go: Pitcher.al.sp_leaders('go',10),
      gidp: Pitcher.al.sp_leaders('gidp',10),
      ab: Pitcher.al.sp_leaders('ab',10),
      cg: Pitcher.al.sp_leaders('cg',10),
      sho: Pitcher.al.sp_leaders('sho',10)
    }
  end

  def nl_leaders
    @leaders = {
      era: Pitcher.nl.sp_leaders_pct('era',10),
      w: Pitcher.nl.sp_leaders('w',10),
      so: Pitcher.nl.sp_leaders('so',10),
      hld: Pitcher.nl.leaders('hld',10),
      sv: Pitcher.nl.leaders('sv',10),
      bsv: Pitcher.nl.leaders('bsv',10),
      ip: Pitcher.nl.sp_leaders('ip',10),
      np: Pitcher.nl.sp_leaders('np',10),
      hr: Pitcher.nl.leaders('hr',10),
      avg: Pitcher.nl.sp_leaders_pct('avg',10),
      slg: Pitcher.nl.sp_leaders_pct('slg',10),
      whip: Pitcher.nl.sp_leaders_pct('whip',10),
      ao: Pitcher.nl.sp_leaders('ao',10),
      go: Pitcher.nl.sp_leaders('go',10),
      gidp: Pitcher.nl.sp_leaders('gidp',10),
      ab: Pitcher.nl.sp_leaders('ab',10),
      cg: Pitcher.nl.sp_leaders('cg',10),
      sho: Pitcher.nl.sp_leaders('sho',10)
    }
  end

end
