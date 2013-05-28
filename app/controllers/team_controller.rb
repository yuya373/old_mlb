class TeamController < ApplicationController

  def index

  end

  def new
    @team = Team.new
    @tname = Team.select('DISTINCT fname')
  end

  def show
  end

  def create
    @name = params[:team][:name]
    @team = Team.where(fname: @name)
    id = @team[0][:team_id]

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
      key = b.keys.to_a
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
      key = b.keys.to_a
      key.each do |k|
        v = b.attribute(k).text
        @data[:pitcher][p_num][k.to_sym] = v
      end
      p_num += 1
    end

  end

end
