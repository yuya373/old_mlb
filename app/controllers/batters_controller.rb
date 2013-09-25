class BattersController < ApplicationController


  def flush
    flash.now[:update] = when_updated(@r_atbat.first)
  end

  def r_batter(batter)
    r_atbat = []
    batter.each do |batter|
      game_counts = batter.team.tb_g
      if batter.ab > (game_counts * 3.1)
        r_atbat << batter
      end
    end
    return r_atbat
  end

  def nr_batter(batter)
    nr_atbat = []
    batter.each do |batter|
      game_counts = batter.team.tb_g
      if batter.ab > (game_counts * 3.1)
      else
        nr_atbat << batter
      end
    end
    return nr_atbat
  end

  def show
    @p_id = params[:p_id]

    @batter = Batter.from_p_id(@p_id)
  end

  def split
    @p_id = params[:p_id]

    @batter = Batter.from_p_id(@p_id)
    @details = @batter.pitch_type_details

  end

  def vs_pitcher
    @p_id = params[:p_id]

    @batter = Batter.from_p_id(@p_id)
    @team = []
    @pitcher = {}
    @batter.atbats.select('distinct pitcher_team').each do |atbat|
      @team << atbat.pitcher_team
      @pitcher[atbat.pitcher_team] = []

    end
      @team.each do |v|
        @batter.atbats.where.not('pitcher_name = ?','-').where('pitcher_team = ?',v).select('distinct pitcher_name, pitcher_id,pitcher_team').each do |pit|
          @pitcher[v] << [pit.pitcher_name,pit.pitcher_id]
        end
      end

    @atbat = Atbat.from_pitcher_id(params[:pitcher]).from_batter_id(params[:batter]).show

  end

  def highlight
    @p_id = params[:p_id]
    @batter = Batter.from_p_id(@p_id)

    @media = @batter.medias
  end




  def all

    @sort = sort('avg')
    @item = @sort[0]
    @direction = @sort[1]

    @batter = Batter.stats(@item,@direction)

    @r_atbat = r_batter(@batter)
    @nr_atbat = nr_batter(@batter)

  end

  def nl
    @sort = sort('avg')
    @item = @sort[0]
    @direction = @sort[1]


    @batter = Batter.nl.stats(@item,@direction)

    @r_atbat = r_batter(@batter)
    @nr_atbat = nr_batter(@batter)

  end



  def al
    @sort = sort('avg')
    @item = @sort[0]
    @direction = @sort[1]

    @batter = Batter.al.stats(@item,@direction)

    @r_atbat = r_batter(@batter)
    @nr_atbat = nr_batter(@batter)

  end

  def leaders
    @leaders = {
      avg: Batter.leaders('avg',10),
      hr: Batter.leaders('hr',10),
      rbi: Batter.leaders('rbi',10),
      b2: Batter.leaders('b2',10),
      b3: Batter.leaders('b3',10),
      h: Batter.leaders('h',10),
      so: Batter.leaders('so',10),
      bb: Batter.leaders('bb',10),
      sb: Batter.leaders('sb',10),
      cs: Batter.leaders('cs',10),
      hbp: Batter.leaders('hbp',10),
      ab: Batter.leaders('ab',10)
    }
  end

  def al_leaders

    @leaders = {
      avg: Batter.al.leaders('avg',10),
      hr: Batter.al.leaders('hr',10),
      rbi: Batter.al.leaders('rbi',10),
      b2: Batter.al.leaders('b2',10),
      b3: Batter.al.leaders('b3',10),
      h: Batter.al.leaders('h',10),
      so: Batter.al.leaders('so',10),
      bb: Batter.al.leaders('bb',10),
      sb: Batter.al.leaders('sb',10),
      cs: Batter.al.leaders('cs',10),
      hbp: Batter.al.leaders('hbp',10),
      ab: Batter.al.leaders('ab',10)

    }
  end

  def nl_leaders
    @leaders = {
      avg: Batter.nl.leaders('avg',10),
      hr: Batter.nl.leaders('hr',10),
      rbi: Batter.nl.leaders('rbi',10),
      b2: Batter.nl.leaders('b2',10),
      b3: Batter.nl.leaders('b3',10),
      h: Batter.nl.leaders('h',10),
      so: Batter.nl.leaders('so',10),
      bb: Batter.nl.leaders('bb',10),
      sb: Batter.nl.leaders('sb',10),
      cs: Batter.nl.leaders('cs',10),
      hbp: Batter.nl.leaders('hbp',10),
      ab: Batter.nl.leaders('ab',10)
    }
  end
end
