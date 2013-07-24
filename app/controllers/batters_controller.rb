class BattersController < ApplicationController

  def batter
    # gid = 2013_05_01_anamlb_oakmlb_1
    gid = params[:gid]
    b_id = params[:b_id]
    @year = gid.slice(0,4)
    @month = gid.slice(5,2)
    @day = gid.slice(8,2)
    url = build_batters_url(gid,b_id)
    doc = Nokogiri::XML(open(url))

    @data = {}

    player = doc.css('Player')

    player.each do |player|
      key = player.keys.to_a
      key.each do |k|
        v = player.attribute(k).text
        @data[k.to_sym] = v
      end

      @data[:season] = {}

      season = player.css('season')
      season.each do |season|
        key = season.keys.to_a
        key.each do |k|
          v = season.attribute(k).text
          @data[:season][k.to_sym] = v
        end
      end

      @data[:career] = {}

      career = player.css('career')
      career.each do |c|
        key = c.keys.to_a
        key.each do |k|
          v = c.attribute(k).text
          @data[:career][k.to_sym] = v
        end
      end

      @data[:month] = {}

      month = player.css('month')
      month.each do |m|
        key = m.keys.to_a
        key.each do |k|
          v = m.attribute(k).text
          @data[:month][k.to_sym] = v
        end
      end

      @data[:team] = {}

      team = player.css('Team')
      team.each do |t|
        key = t.keys.to_a
        key.each do |k|
          v = t.attribute(k).text
          @data[:team][k.to_sym] = v
        end
      end

      @data[:empty] = {}

      empty = player.css('Empty')
      empty.each do |t|
        key = t.keys.to_a
        key.each do |k|
          v = t.attribute(k).text
          @data[:empty][k.to_sym] = v
        end
      end

      @data[:men_on] = {}

      men_on = player.css('Men_On')
      men_on.each do |t|
        key = t.keys.to_a
        key.each do |k|
          v = t.attribute(k).text
          @data[:men_on][k.to_sym] = v
        end
      end

      @data[:risp] = {}

      risp = player.css('RISP')
      risp.each do |t|
        key = t.keys.to_a
        key.each do |k|
          v = t.attribute(k).text
          @data[:risp][k.to_sym] = v
        end
      end

      @data[:loaded] = {}

      loaded = player.css('Loaded')
      loaded.each do |t|
        key = t.keys.to_a
        key.each do |k|
          v = t.attribute(k).text
          @data[:loaded][k.to_sym] = v
        end
      end

      @data[:vs_rhp] = {}

      vs_rhp = player.css('vs_RHP')
      vs_rhp.each do |t|
        key = t.keys.to_a
        key.each do |k|
          v = t.attribute(k).text
          @data[:vs_rhp][k.to_sym] = v
        end
      end

      @data[:vs_lhp] = {}

      vs_lhp = player.css('vs_LHP')
      vs_lhp.each do |t|
        key = t.keys.to_a
        key.each do |k|
          v = t.attribute(k).text
          @data[:vs_lhp][k.to_sym] = v
        end
      end
    end
  end

  def index
  end

  def show
    @p_id = params[:p_id]

    @batter = Batter.from_p_id(@p_id)

    @details = @batter.pitch_type_details

    @pitcher = Atbat.from_batter_id(@p_id).for_batter

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


  def al
    @sort = sort('avg')
    @item = @sort[0]
    @direction = @sort[1]

    @batter = Batter.al.stats(@item,@direction)

    @r_atbat = r_batter(@batter)
    @nr_atbat = nr_batter(@batter)

  end
end
