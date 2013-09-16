require 'open-uri'

class PitchTypeDetail < ActiveRecord::Base

  belongs_to :pitcher, :foreign_key => 'p_id'
  belongs_to :batter, :foreign_key => 'p_id'

  def self.csv
    CSV.open("pitch_type_detail.csv","wb",headers: true) do |csv|
      att = PitchTypeDetail.attribute_names
      att.delete('id')
      att.delete('created_at')
      att.delete('updated_at')

      csv << att

      PitchTypeDetail.find_each do |v|
        col = []

        att.each do |att|
          col << "#{v[att.to_sym]}"
        end

        csv << col
      end
    end

  end

  def self.pitcher_get
    url = {}
    Team.find_each do |team|
      gid = team.game_id

      # 2013/06/01/wasmlb-atlmlb-1
      year = gid.slice(0,4)
      month = gid.slice(5,2)
      day = gid.slice(8,2)
      away_team = gid.slice(11,6)
      home_team = gid.slice(18,6)
      num = gid.slice(25,1)

      if num == '2'
        PitchTypeDetail.seed("#{year}_#{month}_#{day}_#{away_team}_#{home_team}_1")
      end


      p_id_url = "http://gd2.mlb.com/components/game/mlb/year_2013/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/premium/pitchers/"
      begin
        doc = Nokogiri::XML(open(p_id_url)).css('a')
        p_id = []

        doc.each do |doc|
          p_id << doc.attribute('href').text
        end

        p_id.delete_at(0)

        pitch_type = [
          'pch',
          'pcu',
          'pfa',
          'pfc',
          'pff',
          'pfs',
          'pft',
          'pkn',
          'psi',
          'psl'
        ]

        p_id.each do |p_id|
          ary = []
          pitch_type.each do |ty|
            aaa = "http://gd2.mlb.com/components/game/mlb/year_2013/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/premium/pitchers/#{p_id}#{ty}.xml"

            # url = "http://gd2.mlb.com/components/game/mlb/year_2013/month_06/day_28/gid_2013_06_28_wasmlb_nynmlb_1/premium/batters/150029/#{ty}.xml"

            ary << aaa

            url[p_id.to_sym] = ary

          end
        end
      rescue
      end
    end




    url.each do |k,v|
      v.each do |v|
        begin
          doc2 = Nokogiri::XML(open(v))
          sit = doc2.css('sit')
          cont = {
            p_b: 'p',
            p_id: k.slice(0,6),
            p_id_ty: "#{k.slice(0,6)}_#{v.to_s.slice(121,2)}",
            pitch_type: v.to_s.slice(121,2),
            ab: sit.attribute('ab').text,
            avg: sit.attribute('avg').text,
            hr: sit.attribute('hr').text,
            rbi: sit.attribute('rbi').text,
            bb: sit.attribute('bb').text,
            so: sit.attribute('so').text,
            ops: sit.attribute('ops').text,
            rating: sit.attribute('rating').text,
            sweetness: sit.attribute('sweetness').text
          }
          begin
            PitchTypeDetail.where('p_id_ty = ?',cont[:p_id_ty]).where('p_b = ?','p').first.update_attributes!(cont)
          rescue
            PitchTypeDetail.create(cont)
          end
        rescue
        end
      end
    end
  end


  def self.batter_get
    url = {}
    Team.find_each do |team|
      gid = team.game_id

      # 2013/06/01/wasmlb-atlmlb-1
      year = gid.slice(0,4)
      month = gid.slice(5,2)
      day = gid.slice(8,2)
      away_team = gid.slice(11,6)
      home_team = gid.slice(18,6)
      num = gid.slice(25,1)


      p_id_url = "http://gd2.mlb.com/components/game/mlb/year_2013/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/premium/batters/"

      doc = Nokogiri::XML(open(p_id_url)).css('a')
      p_id = []

      doc.each do |doc|
        p_id << doc.attribute('href').text
      end

      p_id.delete_at(0)

      pitch_type = [
        'pch',
        'pcu',
        'pfa',
        'pfc',
        'pff',
        'pfs',
        'pft',
        'pkn',
        'psi',
        'psl'
      ]

      p_id.each do |p_id|
        ary = []
        pitch_type.each do |ty|
          aaa = "http://gd2.mlb.com/components/game/mlb/year_2013/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/premium/batters/#{p_id}#{ty}.xml"

          # url = "http://gd2.mlb.com/components/game/mlb/year_2013/month_06/day_28/gid_2013_06_28_wasmlb_nynmlb_1/premium/batters/150029/#{ty}.xml"

          ary << aaa

          url[p_id.to_sym] = ary

        end
      end
    end



    url.each do |k,v|
      v.each do |v|
        doc2 = Nokogiri::XML(open(v))
        sit = doc2.css('sit')
        cont = {
          p_b: 'b',
          p_id: k.slice(0,6),
          p_id_ty: "#{k.slice(0,6)}_#{v.to_s.slice(120,2)}",
          pitch_type: v.to_s.slice(120,2),
          ab: sit.attribute('ab').text,
          avg: sit.attribute('avg').text,
          hr: sit.attribute('hr').text,
          rbi: sit.attribute('rbi').text,
          bb: sit.attribute('bb').text,
          so: sit.attribute('so').text,
          ops: sit.attribute('ops').text,
          rating: sit.attribute('rating').text,
          sweetness: sit.attribute('sweetness').text
        }
        begin
          PitchTypeDetail.where('p_id_ty = ?',cont[:p_id_ty]).where('p_b = ?','b').first.update_attributes!(cont)
        rescue
          PitchTypeDetail.create(cont)
        end
      end
    end
  end

  def self.seed_pitcher(gid)
    year = gid.slice(0,4)
    month = gid.slice(5,2)
    day = gid.slice(8,2)
    away_team = gid.slice(11,6)
    home_team = gid.slice(18,6)
    num = gid.slice(25,1)


    p_id_url = "http://gd2.mlb.com/components/game/mlb/year_2013/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/premium/pitchers/"

    doc = Nokogiri::XML(open(p_id_url)).css('a')
    p_id = []

    doc.each do |doc|
      p_id << doc.attribute('href').text
    end

    p_id.delete_at(0)

    pitch_type = [
      'pch',
      'pcu',
      'pfa',
      'pfc',
      'pff',
      'pfs',
      'pft',
      'pkn',
      'psi',
      'psl'
    ]
    url = {}
    p_id.each do |p_id|
      ary = []
      pitch_type.each do |ty|
        aaa = "http://gd2.mlb.com/components/game/mlb/year_2013/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/premium/pitchers/#{p_id}#{ty}.xml"

        # url = "http://gd2.mlb.com/components/game/mlb/year_2013/month_06/day_28/gid_2013_06_28_wasmlb_nynmlb_1/premium/batters/150029/#{ty}.xml"

        ary << aaa

        url[p_id.to_sym] = ary

      end
    end

    url.each do |k,v|
        v.each do |v|
          doc2 = Nokogiri::XML(open(v))
          sit = doc2.css('sit')
          cont = {
            p_b: 'p',
            p_id: k.slice(0,6),
            p_id_ty: "#{k.slice(0,6)}_#{v.to_s.slice(121,2)}",
            pitch_type: v.to_s.slice(121,2),
            ab: sit.attribute('ab').text,
            avg: sit.attribute('avg').text,
            hr: sit.attribute('hr').text,
            rbi: sit.attribute('rbi').text,
            bb: sit.attribute('bb').text,
            so: sit.attribute('so').text,
            ops: sit.attribute('ops').text,
            rating: sit.attribute('rating').text,
            sweetness: sit.attribute('sweetness').text
          }
          begin
            PitchTypeDetail.where('p_id_ty = ?',cont[:p_id_ty]).where('p_b = ?','p').first.update_attributes!(cont)
          rescue
            PitchTypeDetail.create(cont)
          end
        end
      end
  end

  def self.seed_batter(gid)
    year = gid.slice(0,4)
    month = gid.slice(5,2)
    day = gid.slice(8,2)
    away_team = gid.slice(11,6)
    home_team = gid.slice(18,6)
    num = gid.slice(25,1)


    p_id_url = "http://gd2.mlb.com/components/game/mlb/year_2013/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/premium/batters/"

    doc = Nokogiri::XML(open(p_id_url)).css('a')
    p_id = []

    doc.each do |doc|
      p_id << doc.attribute('href').text
    end

    p_id.delete_at(0)

    pitch_type = [
      'pch',
      'pcu',
      'pfa',
      'pfc',
      'pff',
      'pfs',
      'pft',
      'pkn',
      'psi',
      'psl'
    ]

    url = {}

    p_id.each do |p_id|
      ary = []
      pitch_type.each do |ty|
        aaa = "http://gd2.mlb.com/components/game/mlb/year_2013/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/premium/batters/#{p_id}#{ty}.xml"

        # url = "http://gd2.mlb.com/components/game/mlb/year_2013/month_06/day_28/gid_2013_06_28_wasmlb_nynmlb_1/premium/batters/150029/#{ty}.xml"

        ary << aaa

        url[p_id.to_sym] = ary

      end
    end

    url.each do |k,v|
      v.each do |v|
        doc2 = Nokogiri::XML(open(v))
        sit = doc2.css('sit')
        cont = {
          p_b: 'b',
          p_id: k.slice(0,6),
          p_id_ty: "#{k.slice(0,6)}_#{v.to_s.slice(120,2)}",
          pitch_type: v.to_s.slice(120,2),
          ab: sit.attribute('ab').text,
          avg: sit.attribute('avg').text,
          hr: sit.attribute('hr').text,
          rbi: sit.attribute('rbi').text,
          bb: sit.attribute('bb').text,
          so: sit.attribute('so').text,
          ops: sit.attribute('ops').text,
          rating: sit.attribute('rating').text,
          sweetness: sit.attribute('sweetness').text
        }
        begin
          PitchTypeDetail.where('p_id_ty = ?',cont[:p_id_ty]).where('p_b = ?','b').first.update_attributes!(cont)
        rescue
          PitchTypeDetail.create(cont)
        end
      end
    end
  end

end
