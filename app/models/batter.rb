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

  def self.test
    print "Hello whenever"
  end

  def self.get
    Team.find_each do |team|
      team_id = team.team_id
      gid = team.game_id
      url = "http://gd2.mlb.com/components/team/stats/#{team_id}-stats.xml"
      begin
        doc = Nokogiri::XML(open(url))
      rescue
        break
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


            begin
              Batter.where('p_id = ?', p_id).first.update_attributes!(@batter)
            rescue
              Batter.create(@batter)
            end
          end
        end
      end
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
      if batter.ab > (game_counts * 3.1)
        batter.update_attributes(reg: 0)
      else
        batter.update_attributes(reg: 1)
      end
    end
  end

  def self.full_stats
    wbb = 0.690
    whbp = 0.722
    wb1 = 0.888
    wb2 = 1.270
    wb3 = 1.615
    whr = 2.1

    Batter.where(reg: 0).each do |batter|
      iso = batter.slg_sort - batter.avg_sort
      k_pct = batter.so.to_f / (batter.ab + batter.bb + batter.hbp + batter.sf).to_f * 100
      bb_pct = (batter.bb).to_f / (batter.ab + batter.bb + batter.hbp + batter.sf).to_f * 100
      babip = (batter.h - batter.hr).to_f / (batter.ab - batter.hr - batter.so + batter.sf).to_f
      woba = (((batter.bb - batter.ibb) * wbb) + (batter.hbp * whbp) + ((batter.h - batter.b2 - batter.b3 - batter.hr) * wb1) + (batter.b2 * wb2) + (batter.b3 * wb3) + (batter.hr * whr) ).to_f / (batter.ab + batter.bb - batter.ibb + batter.sf + batter.hbp).to_f

      batter.update_attributes(
        iso: iso,
        k_pct: k_pct,
        bb_pct: bb_pct,
        babip: babip,
        woba: woba
        )
    end
  end
end
