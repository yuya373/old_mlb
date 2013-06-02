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

  def all_pitcher
    @all_pitcher = Player.where(:pos => "P")
    number = 0
    @pitcher = {}
    @all_pitcher.each do |pitcher|
      @pitcher[number] = {
        p_id: pitcher[:p_id],
        team_id: pitcher[:team_id],
        name: pitcher[:name],
      }

    url = "http://gd2.mlb.com/components/game/mlb/year_2013/pitchers/#{@pitcher[number][:p_id]}.xml"

    doc = Nokogiri::XML(open(url))

    pitching = doc.css('pitching')

    @pitcher[number] = {
      era: pitching.attribute('era').text,
      w: pitching.attribute('w').text,
      l: pitching.attribute('l').text,
      whip: pitching.attribute('whip').text,
      ip: pitching.attribute('s_ip').text,
      h: pitching.attribute('s_h').text,
      er: pitching.attribute('s_er').text,
      r: pitching.attribute('s_r').text,
      bb: pitching.attribute('s_bb').text,
      k: pitching.attribute('s_k').text,
      sv: pitching.attribute('s_sv').text,
      hbp: pitching.attribute('s_hbp').text,
      hra: pitching.attribute('s_hra').text
    }

    Pitcher.create(@pitcher[number])
    number += 1
    end
  end

end
