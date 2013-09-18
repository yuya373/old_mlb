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
      avg: Batter.leaders('avg'),
      hr: Batter.leaders('hr'),
      rbi: Batter.leaders('rbi'),
      b2: Batter.leaders('b2'),
      b3: Batter.leaders('b3'),
      h: Batter.leaders('h'),
      so: Batter.leaders('so'),
      bb: Batter.leaders('bb'),
      sb: Batter.leaders('sb'),
      cs: Batter.leaders('cs'),
      hbp: Batter.leaders('hbp'),
      ab: Batter.leaders('ab')
    }
  end

  def al_leaders

    @leaders = {
      avg: Batter.al.leaders('avg'),
      hr: Batter.al.leaders('hr'),
      rbi: Batter.al.leaders('rbi'),
      b2: Batter.al.leaders('b2'),
      b3: Batter.al.leaders('b3'),
      h: Batter.al.leaders('h'),
      so: Batter.al.leaders('so'),
      bb: Batter.al.leaders('bb'),
      sb: Batter.al.leaders('sb'),
      cs: Batter.al.leaders('cs'),
      hbp: Batter.al.leaders('hbp'),
      ab: Batter.al.leaders('ab')

    }
  end

  def nl_leaders
    @leaders = {
      avg: Batter.nl.leaders('avg'),
      hr: Batter.nl.leaders('hr'),
      rbi: Batter.nl.leaders('rbi'),
      b2: Batter.nl.leaders('b2'),
      b3: Batter.nl.leaders('b3'),
      h: Batter.nl.leaders('h'),
      so: Batter.nl.leaders('so'),
      bb: Batter.nl.leaders('bb'),
      sb: Batter.nl.leaders('sb'),
      cs: Batter.nl.leaders('cs'),
      hbp: Batter.nl.leaders('hbp'),
      ab: Batter.nl.leaders('ab')
    }
  end
end
