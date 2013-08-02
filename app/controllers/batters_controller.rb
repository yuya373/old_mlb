class BattersController < ApplicationController
  after_filter :flush, only: [:all, :al, :nl]


  def flush
    flash[:notice] = when_updated(@r_atbat.first)
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

    @details = @batter.pitch_type_details


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
end
