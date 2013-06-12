class TeamController < ApplicationController

  before_action :set_team, only: [:show]


  def index

  end

  def new
    @team = Team.new
    @team_name = Team.select('DISTINCT team_name')
    @ale_team = Team.league_division(['110','111','141','139','147'])
    @alc_team = Team.league_division(['114','116','142','118','145'])
    @alw_team = Team.league_division(['108','117','133','136','140'])
    @nle_team = Team.league_division(['120','121','143','144','146'])
    @nlc_team = Team.league_division(['112','113','134','138','158'])
    @nlw_team = Team.league_division(['109','115','119','135','137'])
  end

  def show
    @b_thead = [
      'tb_avg',
      'tb_slg',
      'tb_obp',
      'tb_ops',
      'tb_ab',
      'tb_tb',
      'tb_h',
      'tb_b2',
      'tb_b3',
      'tb_hr',
      'tb_rbi',
      'tb_sac',
      'tb_sf',
      'tb_bb',
      'tb_ibb',
      'tb_so',
      'tb_sb',
      'tb_cs',
      'tb_gidp'
    ]

    @p_thead = [
      'tp_era',
      'tp_whip',
      'tp_ip',
      'tp_er',
      'tp_h',
      'tp_r',
      'tp_hr',
      'tp_hb',
      'tp_bb',
      'tp_ibb',
      'tp_so',
      'tp_wp',
      'tp_w',
      'tp_l',
      'tp_cg',
      'tp_sho',
      'tp_sv',
      'tp_bsv',
      'tp_svo',
    ]
    @of_batter = []
    @if_batter = []
    @team_batter.each do |batter|
      case batter.pos
      when 'CF'
        @of_batter << batter

      when 'LF'
        @of_batter << batter

      when 'RF'
        @of_batter << batter
      when 'P'
      else
        @if_batter << batter
      end

    end
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

  private
  def set_team
    @team = Team.where('team_id = ?', params[:team_id]).first
    @team_batter = @team.batters.order('pos asc')
    @team_pitcher = @team.pitchers.order('ip desc')
  end
end
