require 'open-uri'
require 'csv'

class Batter < ActiveRecord::Base
  self.primary_key = 'p_id'
  validates_uniqueness_of :p_id
  belongs_to :team, :foreign_key => 'team_id'
  has_many :pitchings, :foreign_key => 'batter_id'
  has_many :pitch_type_details, :foreign_key => 'p_id'
  has_many :atbats, :foreign_key => 'batter_id'
  has_many :batter_favorites
  has_many :medias, foreign_key: :p_id

  scope :from_p_id, lambda{|p_id| where('p_id = ?',p_id).first}
  scope :if_batter, lambda{where('pos = ? or pos = ? or pos = ? or pos = ? or pos = ? or pos = ?', '1B', '2B', '3B', 'SS', 'C', 'D').order('pos')}
  scope :of_batter, lambda{where('pos = ? or pos = ? or pos = ? or pos = ?','CF','LF','RF','O').order('pos')}
  scope :stats, lambda{|item,direction| where('not pos = ?',  'P').order(item + ' ' + direction)}
  scope :nl, lambda{where('league_id = 104')}
  scope :al, lambda{where('league_id = 103')}
  scope :leaders, lambda{|stats,num| where('reg = 0').order(" #{stats} DESC").limit(num)}


  def self.csv_to_batters(file_name)

    batters = CSV.table(file_name)
    case file_name
    when 'pit_batters.csv'
      team_id = 134
    when 'reds_batters.csv'
      team_id = 113
    end

    batters.each do |row|
      batter = {
        name_display_first_last: row[:name],
        g: row[:g],
        ab: row[:ab],
        tpa: row[:pa],
        h: row[:h],
        b2: row['2b'],
        b3: row['3b'],
        hr: row[:hr],
        r: row[:r],
        rbi: row[:rbi],
        bb: row[:bb],
        ibb:row[:ibb],
        so: row[:so],
        hbp: row[:hbp],
        sf: row[:sf],
        sac: row[:sh],
        gidp: row[:gdp],
        sb: row[:sb],
        cs: row[:cs],
        avg: row[:avg],
        avg_sort: row[:avg],
        rbi: row[:rbi],
        r: row[:r],
        obp: row[:obp],
        obp_sort: row[:obp],
        slg: row[:slg],
        slg_sort: row[:slg],
        ops: row[:ops],
        ops_sort: row[:ops],
        team_id: team_id
      }
      begin
        Batter.where(name_display_first_last: batter[:name_display_first_last]).first.update_attributes!(batter)
      rescue
        Batter.create(batter)
      end
    end
  end

  def self.seed(game_id,team_id)
    gid = game_id
    url = "http://gd2.mlb.com/components/team/stats/#{team_id}-stats.xml"
    begin
      doc = Nokogiri::XML(open(url))
    rescue
    else

      batter = doc.css('TeamStats batter')
      batter.each do |batter|
        @batter = {}
        key = batter.keys.to_a
        key.each do |k|
          v = batter.attribute(k).text
          d_k = k.downcase
          if d_k == 'id'
            d_k = 'p_id'
          end
          @batter[d_k.to_sym] = v
        end

        p_id = @batter[:p_id]

        year = gid.slice(0,4)
        month = gid.slice(5,2)
        day = gid.slice(8,2)
        # 2013/06/01/wasmlb-atlmlb-1
        away_team = gid.slice(11,6)
        # away_team = 'minmlb'
        home_team = gid.slice(18,6)
        # home_team = 'wasmlb'
        num = gid.slice(25,1)

        b_url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/batters/#{p_id}.xml"
        begin
          data = Nokogiri::XML(open(b_url))
        rescue
          begin
            Batter.where('p_id = ?', p_id).first.update_attributes!(@batter)
          rescue
            Batter.create(@batter)
          end

        else
          player = data.css('Player')
          @batter[:jersey_number] = player.attribute('jersey_number').text
          @batter[:height] = player.attribute('height').text
          @batter[:weight] = player.attribute('weight').text
          @batter[:dob] = player.attribute('dob').text

          career = data.css('career')
          career.each do |career|
            c_key = career.keys.to_a
            c_key.each do |k|
              key = "career_#{k}"
              @batter[key.to_sym] = career.attribute(k).text
            end
          end

          month = data.css('month')
          month.each do |month|
            m_key = month.keys.to_a
            m_key.each do |k|
              key = "month_#{k}"
              @batter[key.to_sym] = month.attribute(k).text
            end
          end

          empty = data.css('Empty')
          empty.each do |empty|
            e_key = empty.keys.to_a
            e_key.each do |k|
              key = "empty_#{k}"
              @batter[key.to_sym] = empty.attribute(k).text
            end
          end

          men_on = data.css('Men_On')
          men_on.each do |men_on|
            mo_key = men_on.keys.to_a
            mo_key.each do |k|
              key = "men_on_#{k}"
              @batter[key.to_sym] = men_on.attribute(k).text
            end
          end

          risp = data.css('RISP')
          risp.each do |risp|
            r_key = risp.keys.to_a
            r_key.each do |k|
              key = "risp_#{k}"
              @batter[key.to_sym] = risp.attribute(k).text
            end
          end

          loaded = data.css('Loaded')
          loaded.each do |loaded|
            l_key = loaded.keys.to_a
            l_key.each do |k|
              key = "loaded_#{k}"
              @batter[key.to_sym] = loaded.attribute(k).text
            end
          end

          vs_lhp = data.css('vs_LHP')
          vs_lhp.each do |vs_lhp|
            lh_key = vs_lhp.keys.to_a
            lh_key.each do |k|
              key = "vs_lhp_#{k}"
              @batter[key.to_sym] = vs_lhp.attribute(k).text
            end
          end

          vs_rhp = data.css('vs_RHP')
          vs_rhp.each do |vs_rhp|
            rh_key = vs_rhp.keys.to_a
            rh_key.each do |k|
              key = "vs_rhp_#{k}"
              @batter[key.to_sym] = vs_rhp.attribute(k).text
            end
          end

          @batter[:season] = Game::SEASON


          begin
            Batter.where('p_id = ?', p_id).where(year: Game::YEAR).where(season: Game::SEASON).first.update_attributes!(@batter)
          rescue
            Batter.create(@batter)
          end
        end
      end
    end
  end

  def self.get
    Team.find_each do |team|
      team_id = team.team_id
      game_id = team.game_id

      seed(game_id,team_id)
    end
  end

  def self.csv
    CSV.open("batter.csv","wb",headers: true) do |csv|
      att = Batter.attribute_names
      att.delete('id')
      att.delete('created_at')
      att.delete('updated_at')

      csv << att

      Batter.find_each do |v|
        col = []

        att.each do |att|
          col << "#{v[att.to_sym]}"
        end

        csv << col
      end
    end
  end

  def self.regulation
    Batter.find_each do |batter|
      game_counts = batter.team.tb_g
      if batter.ab > (162 * 3.1)
        batter.update_attributes(reg: 0)
      else
        batter.update_attributes(reg: 1)
      end
    end
  end

  WBB = 0.690
  WHBP = 0.722
  WB1 = 0.888
  WB2 = 1.270
  WB3 = 1.615
  WHR = 2.1
  WOBA_SCALE = 1.276

  def self.full_stats

    Batter.find_each do |batter|
      if batter.ab != 0.0 and (batter.ab - batter.hr - batter.so + batter.sf).to_f !=0
        iso = batter.slg_sort - batter.avg_sort
        babip = (batter.h - batter.hr).to_f / (batter.ab - batter.hr - batter.so + batter.sf).to_f
        k_pct = batter.so.to_f / (batter.ab + batter.bb + batter.hbp + batter.sf).to_f * 100
        bb_pct = (batter.bb).to_f / (batter.ab + batter.bb + batter.hbp + batter.sf).to_f * 100
        woba = (((batter.bb - batter.ibb) * WBB) + (batter.hbp * WHBP) + ((batter.h - batter.b2 - batter.b3 - batter.hr) * WB1) + (batter.b2 * WB2) + (batter.b3 * WB3) + (batter.hr * WHR) ).to_f / (batter.ab + batter.bb - batter.ibb + batter.sf + batter.hbp).to_f
        wraa = ((woba.round(3) - batter.team.lg_woba.round(3)) / WOBA_SCALE) * batter.tpa.to_f

        # (((wOBA – lgwOBA) / wOBAScale) + (lgR/PA)) * PA
        wrc = wraa + (batter.team.lg_r.to_f / batter.team.lg_tpa.to_f) * batter.tpa

      else
        k_pct = nil
        bb_pct = nil
        woba = nil
        wraa = nil
        wrc = nil
        iso = nil
        babip = nil
      end

      batter.update_attributes(
        iso: iso,
        k_pct: k_pct,
        bb_pct: bb_pct,
        babip: babip,
        woba: woba,
        wraa: wraa,
        wrc: wrc
        )
    end
  end
end
