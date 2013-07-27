class TeamController < ApplicationController


  def all_hitting
    @sort = sort('tb_avg')
    @item = @sort[0]
    @direction = @sort[1]

    @team = Team.all.stats(@item,@direction).batting
  end

  def all_pitching
    @sort = sort('tp_era')
    @item = @sort[0]
    @direction = @sort[1]

    @team = Team.all.stats(@item,@direction).pitching
  end
  def al_hitting
    @sort = sort('tb_avg')
    @item = @sort[0]
    @direction = @sort[1]

    @team = Team.al.stats(@item,@direction).batting
  end

  def al_pitching
    @sort = sort('tp_era')
    @item = @sort[0]
    @direction = @sort[1]

    @team = Team.al.stats(@item,@direction).pitching
  end

  def nl_hitting
    @sort = sort('tb_avg')
    @item = @sort[0]
    @direction = @sort[1]

    @team = Team.nl.stats(@item,@direction).batting

  end

  def nl_pitching
    @sort = sort('tp_era')
    @item = @sort[0]
    @direction = @sort[1]


    @team = Team.nl.stats(@item,@direction).pitching
  end


  def index
    @team = Team.first
    @ale_team = Team.al.division('e').order_by_win_pct
    @alc_team = Team.al.division('c').order_by_win_pct
    @alw_team = Team.al.division('w').order_by_win_pct
    @nle_team = Team.nl.division('e').order_by_win_pct
    @nlc_team = Team.nl.division('c').order_by_win_pct
    @nlw_team = Team.nl.division('w').order_by_win_pct
  end

  def show
    @team = Team.where('team_id = ?', params[:team_id]).first

    @of_batter = @team.batters.of_batter
    @if_batter = @team.batters.if_batter
    @team_pitcher = @team.pitchers

  end

  def create
    @name = params[:team][:team_name]
    @team = Team.where('team_name = ?',@name).first
    id = @team[:team_id]

    url = build_team_url(id)

    doc = Nokogiri::XML(open(url))

    @aa = doc.css('away_batting').empty?

    team_stats = doc.css('TeamStats')
    @data = {}
    team_stats.each do |t|
      key = t.keys.to_a
      key.each do |k|
        v = t.attribute(k).text
        @data[k.to_sym] = v
      end
    end

    if doc.css('home_batting').empty?
      h_a_b = 'away_batting'
    else
      h_a_b = 'home_batting'
    end

    batting = doc.css("#{h_a_b}")
    @data[h_a_b.to_sym] = {}
    batting.each do |h|
      key = h.keys.to_a
      key.each do |k|
        v = h.attribute(k).text
        @data[h_a_b.to_sym][k.to_sym] = v
      end
    end

    batter = doc.css('batter')
    b_num = 0
    @data[:batter] = {}

    batter.each do |b|
      key = [
        'id',
      'name',
      'POS',
      'JERSEY_NUMBER',
      'H',
      'AB',
      'AVG',
      'SLG',
      'G',
      'R',
      'B2',
      'B3',
      'HR',
      'RBI',
      'SAC',
      'SF',
      'HBP',
      'BB',
      'IBB',
      'SO',
      'SB',
      'CS',
      'GIDP',
      'OPS',
      'OBP',
      'GO',
      'AO',
      'TPA'
    ]
      @data[:batter][b_num] = {}
      key.each do |k|
        v = b.attribute(k).text
        @data[:batter][b_num][k.to_sym] = v
      end
      b_num += 1
    end

    if doc.css('home_pitching').empty?
      h_a_p = 'away_pitching'
    else
      h_a_p = 'home_pitching'
    end

     pitching = doc.css("#{h_a_p}")
    @data[h_a_p.to_sym] = {}
    pitching.each do |b|
      key = b.keys.to_a
      key.each do |k|
        v = b.attribute(k).text
        @data[h_a_p.to_sym][k.to_sym] = v
      end
    end

     pitcher = doc.css('pitcher')
    @data[:pitcher] = {}
    p_num = 0
    pitcher.each do |b|
      @data[:pitcher][p_num] = {}
      key = [
        'id',
        'name',
        'JERSEY_NUMBER',
        'IP',
        'NP',
        'ER',
        'ERA',
        'AVG',
        'SLG',
        'WHIP',
        'H',
        'R',
        'HR',
        'HB',
        'BB',
        'IBB',
        'SO',
        'WP',
        'BK',
        'GIDP',
        'P_INH_RUNNER',
        'P_INH_RUNNER_SCORED',
        'AO',
        'GO',
        'G',
        'GS',
        'W',
        'L',
        'HLD',
        'GF',
        'CG',
        'SHO',
        'SV',
        'BSV',
        'SVO']
      key.each do |k|
        v = b.attribute(k).text
        @data[:pitcher][p_num][k.to_sym] = v
      end
      p_num += 1
    end

  end

end
