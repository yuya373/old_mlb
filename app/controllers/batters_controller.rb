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

  def al_batter
    @b = Batter.where('p_id = :p_id',{:p_id => '492841'})
    @batter = @b.first
  end
end
