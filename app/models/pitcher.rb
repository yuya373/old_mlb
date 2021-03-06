require 'open-uri'
require 'csv'

class Pitcher < ActiveRecord::Base
  self.primary_key = 'p_id'
  validates_uniqueness_of :p_id
  belongs_to :team, :foreign_key => 'team_id'
  has_many :pitchings, :foreign_key => 'pitcher_id'
  has_many :atbats, :foreign_key => 'pitcher_id'
  has_many :pitch_type_details, :foreign_key => 'p_id'
  has_many :pitch_tendencies, :foreign_key => 'p_id'
  has_many :pitcher_favorites
  has_many :medias, foreign_key: :p_id


  scope :stats, lambda{|item,direction| where.not('g = ?',0).select('p_id,team_id,team_abbrev,name_display_first_last,g,gs,w,l,hld,sv,bsv,svo,ip_sort,era_sort,whip_sort,avg_sort,slg_sort,so,ao,go,gidp,p_inh_runner,p_inh_runner_scored,cg,sho,gf,np,er,h,r,hr,hb,bb,ibb,wp,tpa,ab,sf,sac,pct_sort,bk,updated_at').order(item + ' ' + direction)}
  scope :al, lambda{where('league_id = 103')}
  scope :nl, lambda{where('league_id = 104')}
  scope :from_p_id, lambda{|p_id| where('p_id = ?',p_id).first}
  scope :sp_leaders_pct, lambda{|stats,num| where('reg = 0').order("#{stats} ASC").limit(num)}
  scope :sp_leaders, lambda{|stats,num| where('reg = 0').order("#{stats} DESC").limit(num)}
  scope :leaders, lambda{|stats,num| order("#{stats} DESC").limit(num)}


  def self.csv_to_pitchers(file_name)
    pitchers = CSV.table(file_name)
    pitchers.each do |row|
      pitcher = {
        name_display_first_last: row[:name],
        w: row[:w],
        l: row[:l],
        sv: row[:sv],
        g: row[:g],
        gs: row[:gs],
        ip: row[:ip],
        era: row[:era],
        era_sort: row[:era],
        cg: row[:cg],
        sho: row[:sho],
        bsv: row[:bs],
        ip: row[:ip],
        ip_sort: row[:ip],
        h: row[:h],
        r: row[:r],
        er: row[:er],
        hr: row[:hr],
        bb: row[:bb],
        ibb: row[:ibb],
        hb: row[:hbp],
        wp: row[:wp],
        bk: row[:bk],
        so: row[:so],
        avg: row[:avg],
        avg_sort: row[:avg],
        whip: row[:whip],
        whip_sort: row[:whip],
        hld: row[:hld]
      }

      begin
        Pitcher.where(name_display_first_last: pitcher[:name_display_first_last]).first.update_attributes!(pitcher)
      rescue
        Pitcher.create(pitcher)
      end
    end
  end

  def self.seed(game_id,team_id)
    gid = game_id
    url = "http://gd2.mlb.com/components/team/stats/#{team_id}-stats.xml"
    begin
      doc = Nokogiri::XML(open(url))

      pitcher = doc.css('TeamStats pitcher')
      pitcher.each do |pitcher|
        @pitcher = {}
        key = pitcher.keys.to_a
        key.each do |k|
          v = pitcher.attribute(k).text
          d_k = k.downcase
          if d_k == 'id'
            d_k = 'p_id'
          end
          @pitcher[d_k.to_sym] = v
        end
        p_id = @pitcher[:p_id]

        year = gid.slice(0,4)
        month = gid.slice(5,2)
        day = gid.slice(8,2)
        # 2013/06/01/wasmlb-atlmlb-1
        away_team = gid.slice(11,6)
        home_team = gid.slice(18,6)
        num = gid.slice(25,1)
        p_url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/pitchers/#{p_id}.xml"
        begin
          data = Nokogiri::XML(open(p_url))
        rescue
          data = nil
        end
        if data == nil
          begin
            Pitcher.where('p_id = ?', p_id).first.update_attributes!(@pitcher)
          rescue
            Pitcher.create(@pitcher)
          end
        else
          player = data.css('Player')
          @pitcher[:height] = player.attribute('height').text
          @pitcher[:weight] = player.attribute('weight').text
          @pitcher[:dob] = player.attribute('dob').text

          career = data.css('career')
          career.each do |career|
            c_key = career.keys.to_a
            c_key.each do |k|
              key = "career_#{k}"
              @pitcher[key.to_sym] = career.attribute(k).text
            end
          end

          month = data.css('Month')
          month.each do |month|
            m_key = month.keys.to_a
            m_key.each do |k|
              key = "month_#{k}"
              @pitcher[key.to_sym] = month.attribute(k).text
            end
          end

          empty = data.css('Empty')
          empty.each do |empty|
            e_key = empty.keys.to_a
            e_key.each do |k|
              key = "empty_#{k}"
              @pitcher[key.to_sym] = empty.attribute(k).text
            end
          end

          men_on = data.css('Men_On')
          men_on.each do |men_on|
            mo_key = men_on.keys.to_a
            mo_key.each do |k|
              key = "men_on_#{k}"
              @pitcher[key.to_sym] = men_on.attribute(k).text
            end
          end

          risp = data.css('RISP')
          risp.each do |risp|
            r_key = risp.keys.to_a
            r_key.each do |k|
              key = "risp_#{k}"
              @pitcher[key.to_sym] = risp.attribute(k).text
            end
          end

          loaded = data.css('Loaded')
          loaded.each do |loaded|
            l_key = loaded.keys.to_a
            l_key.each do |k|
              key = "loaded_#{k}"
              @pitcher[key.to_sym] = loaded.attribute(k).text
            end
          end

          vs_lhb = data.css('vs_LHB')
          vs_lhb.each do |vs_lhb|
            lh_key = vs_lhb.keys.to_a
            lh_key.each do |k|
              key = "vs_lhb_#{k}"
              @pitcher[key.to_sym] = vs_lhb.attribute(k).text
            end
          end

          vs_rhb = data.css('vs_RHB')
          vs_rhb.each do |vs_rhb|
            rh_key = vs_rhb.keys.to_a
            rh_key.each do |k|
              key = "vs_rhb_#{k}"
              @pitcher[key.to_sym] = vs_rhb.attribute(k).text
            end
          end


          begin
            Pitcher.where('p_id = ?', p_id).first.update_attributes!(@pitcher)
          rescue
            Pitcher.create(@pitcher)
          end
        end
      end
    rescue
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
    CSV.open('test/fixtures/pitcher.csv','wb', headers: true) do |csv|

      att = Pitcher.attribute_names
      att.delete('id')
      att.delete('created_at')
      att.delete('updated_at')

      csv << att

      Pitcher.find_each do |pitcher|
        col = []

        att.each do |att|
          col << "#{pitcher[att.to_sym]}"
        end

        csv << col
      end
    end
  end

  def self.regulation
    Pitcher.find_each do |pitcher|
      game_counts = pitcher.team.tp_g
      if pitcher.ip > (game_counts * 1)
        pitcher.update_attributes(reg: 0)
      else
        pitcher.update_attributes(reg: 1)
      end
    end
  end

  def self.full_stats
    Pitcher.find_each do |pitcher|
      if pitcher.ab == 0 or pitcher.ip_sort == 0 or pitcher.bb == 0
        next
      else

        lg_era = pitcher.team.lg_era
        lg_bb = pitcher.team.lg_bb
        lg_hr = pitcher.team.lg_hr
        lg_ibb = pitcher.team.lg_ibb
        lg_hb = pitcher.team.lg_hb
        lg_so = pitcher.team.lg_so
        lg_ip = pitcher.team.lg_ip
        lg_fip = pitcher.team.lg_fip
        lg_ra = pitcher.team.lg_ra

        c_fip = lg_era - ((13 * lg_hr + 3 * (lg_bb + lg_hb) - 2 * lg_so) / lg_ip)
        fip = (13 * pitcher.hr + 3 * (pitcher.bb + pitcher.hb) - 2 * pitcher.so) / pitcher.ip_sort + 3.047

        ra = (pitcher.r / pitcher.ip_sort) * 9


        @stats = {
          k_pct: (pitcher.so.to_f/pitcher.ab.to_f) * 100,
          bb_pct: (pitcher.bb.to_f/pitcher.ab.to_f) * 100,
          k_9: (pitcher.so * 9.0)/pitcher.ip_sort,
          bb_9: (pitcher.bb * 9.0)/pitcher.ip_sort,
          hr_9: (pitcher.hr * 9.0)/pitcher.ip_sort,
          k_bb: pitcher.so.to_f/pitcher.bb.to_f,
          babip: (pitcher.h - pitcher.hr).to_f/(pitcher.ab - pitcher.so - pitcher.hr + pitcher.sf).to_f,
          uera: (pitcher.r - pitcher.er) * 9.0 / pitcher.ip_sort,
          lob_pct: ((pitcher.h + pitcher.bb + pitcher.hb - pitcher.r).to_f / (pitcher.h + pitcher.bb  + pitcher.hb - 1.4 * pitcher.hr)) * 100,
          fip: fip,
          e_f: pitcher.era_sort - fip,
          fip_minus: fip/lg_fip,
          p_r: ((lg_era - pitcher.era) / 9) * pitcher.ip_sort,
          rsaa: ((lg_ra - ra) / 9) * pitcher.ip_sort
        }

        pitcher.update_attributes(@stats)
      end
    end
  end
end
