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
