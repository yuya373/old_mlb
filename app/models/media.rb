require 'open-uri'

class Media < ActiveRecord::Base

  belongs_to :game, :foreign_key => 'game_id'
  belongs_to :pitcher, foreign_key: :p_id
  belongs_to :batter, foreign_key: :p_id
  belongs_to :team


  def self.get
    Team.find_each do |team|


      # gid = '2013_05_19_detmlb_texmlb_1'
      gid = team.game_id
      year = gid.slice(0,4)
      month = gid.slice(5,2)
      day = gid.slice(8,2)
      # 2013/06/01/wasmlb-atlmlb-1
      away_team = gid.slice(11,6)
      home_team = gid.slice(18,6)
      num = gid.slice(25,1)

      url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/media/mobile.xml"

      if num == '2'
        Media.seed("#{year}_#{month}_#{day}_#{away_team}_#{home_team}_1")
      end
      begin
        doc = Nokogiri::XML(open(url))
      rescue
      else
        high = doc.css('highlights')

          high.css('media').each do |media|
            @media = {}
            @media[:game_id] = gid
            @media[:des] = media.css('bigblurb').text
            @media[:date] = Date.new(year.to_i,month.to_i,day.to_i)
            @media[:headline] = media.css('headline').text
            @media[:duration] = media.css('duration').text
            @media[:sv_id] = media.attribute('id').text.to_i



            if media.key?('condensed')
              @media[:media_type] = 'condensed'
            else
              @media[:media_type] = media.attribute('type').text
            end



            if media.css('player').empty?
            else
              @media[:p_id] = media.css('player').attribute('player_id').text.to_i
            end

            media.css('keywords>keyword').each do |keyword|
              if keyword.attribute('type').text == 'team_id'
                @media[:team_id] =keyword.attribute('value').text.to_i
              else keyword.attribute('type').text == 'sv_id'
                # @media[:sv_id] = keyword.attribute('value').text.to_i
              end
            end

            media.css('thumbnails>thumb').each do |thumbnail|
              case thumbnail.attribute('type').text
              when '8'
                @media[:thumb] = thumbnail.text
              when '43'
                @media[:thumb] = thumbnail.text
              end
            end

            media.css('url').each do |url|
              if (media.attribute('condensed')) && (media.attribute('condensed').text == 'true')
                case url.attribute('playback-scenario').text
                when '3GP_H264_550K_320X240'
                  @media[:url] = url.text
                end
              else
                case url.attribute('playback-scenario').text
                when 'FLASH_1200K_640X360'
                  @media[:url] = url.text
                end
              end
            end


            begin
              Media.where(sv_id: @media[:sv_id]).first.update_attributes!(@media)
            rescue
              Media.create(@media)
            end
          end
      end
    end
  end

  def self.seed(gid)
    # gid = '2013_05_19_detmlb_texmlb_1'
    year = gid.slice(0,4)
    month = gid.slice(5,2)
    day = gid.slice(8,2)
    # 2013/06/01/wasmlb-atlmlb-1
    away_team = gid.slice(11,6)
    home_team = gid.slice(18,6)
    num = gid.slice(25,1)

    url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/media/mobile.xml"
    begin
      doc = Nokogiri::XML(open(url))
    rescue
    else
      high = doc.css('highlights')

        high.css('media').each do |media|
          @media = {}
          @media[:game_id] = gid


          if media.css('player').empty?
          else
            @media[:p_id] = media.css('player').attribute('player_id').text.to_i
          end
          @media[:des] = media.css('bigblurb').text
          @media[:date] = Date.new(year.to_i,month.to_i,day.to_i)
          @media[:headline] = media.css('headline').text
          @media[:duration] = media.css('duration').text
          @media[:sv_id] = media.attribute('id').text.to_i

          media.css('keywords>keyword').each do |keyword|
            if keyword.attribute('type').text == 'team_id'
              @media[:team_id] =keyword.attribute('value').text.to_i
            else keyword.attribute('type').text == 'sv_id'
              # @media[:sv_id] = keyword.attribute('value').text.to_i
            end
          end

          media.css('thumbnails>thumb').each do |thumbnail|
            case thumbnail.attribute('type').text
            when '8'
              @media[:thumb] = thumbnail.text
            when '43'
              @media[:thumb] = thumbnail.text
            end
          end

          media.css('url').each do |url|
            if (media.attribute('condensed')) && (media.attribute('condensed').text == 'true')
              case url.attribute('playback-scenario').text
              when '3GP_H264_550K_320X240'
                @media[:url] = url.text
              end
            else
              case url.attribute('playback-scenario').text
              when 'FLASH_1200K_640X360'
                @media[:url] = url.text
              end
            end
          end


          begin
            Media.where(sv_id: @media[:sv_id]).first.update_attributes!(@media)
          rescue
            Media.create(@media)
          end
        end
    end
  end

  def self.cg_get
    Team.find_each do |team|

      # gid = '2013_05_19_detmlb_texmlb_1'
      gid = team.game_id
      year = gid.slice(0,4)
      month = gid.slice(5,2)
      day = gid.slice(8,2)
      # 2013/06/01/wasmlb-atlmlb-1
      away_team = gid.slice(11,6)
      home_team = gid.slice(18,6)
      num = gid.slice(25,1)

      if num == '2'
        Media.cg_seed("#{year}_#{month}_#{day}_#{away_team}_#{home_team}_1")
      end


      url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}/media/instadium.xml"
      begin
        doc = Nokogiri::XML(open(url))

        media = doc.css('media')
        media.each do |media|
          if media.key?('condensed')
            id = media.attribute('id').text
            date = media.attribute('date').text
            type = media.attribute('type').text
            headline = media.css('headline').text
            duration = media.css('duration').text
            thumb = media.css('thumb').text
            m_url = media.css('url')
            m_url.each do |m_url|
              if m_url.attribute('playback-scenario').text == '3GP_H264_550K_320X240'
                url = m_url.text
              end
            end

            @media = {
              game_id: gid.tr('-','_'),
              sv_id: id,
              date: date,
              media_type: 'condensed',
              headline: headline,
              duration: duration,
              thumb: thumb,
              url: url
            }

            begin
              Media.where(game_id: @media[:game_id]).where(sv_id: @media[:sv_id]).first.update_attributes!(@media)
            rescue
              Media.create(@media)
            end
          end
        end
      rescue
      end
    end
  end

  def self.cg_seed(gid)
    # gid = '2013_05_19_detmlb_texmlb_2'
    year = gid.slice(0,4)
    month = gid.slice(5,2)
    day = gid.slice(8,2)
    # 2013/06/01/wasmlb-atlmlb-2
    away_team = gid.slice(11,6)
    home_team = gid.slice(18,6)
    num = gid.slice(25,1)


    url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/gid_#{year}_#{month}_#{day}_#{away_team}_#{home_team}_1/media/instadium.xml"
    begin
      doc = Nokogiri::XML(open(url))

      media = doc.css('media')
      media.each do |media|
        if media.key?('condensed')
          id = media.attribute('id').text
          date = media.attribute('date').text
          type = media.attribute('type').text
          headline = media.css('headline').text
          duration = media.css('duration').text
          thumb = media.css('thumb').text
          m_url = media.css('url')
          m_url.each do |m_url|
            if m_url.attribute('playback-scenario').text == '3GP_H264_550K_320X240'
              url = m_url.text
            end
          end
          # 2013_07_30_arimlb-tbamlb-1
          @media = {
            game_id: "#{year}_#{month}_#{day}_#{away_team}_#{home_team}_#{num}",
            sv_id: id,
            date: date,
            media_type: 'condensed',
            headline: headline,
            duration: duration,
            thumb: thumb,
            url: url
          }

          begin
            Media.where(game_id: @media[:game_id]).where(sv_id: @media[:sv_id]).first.update_attributes!(@media)
          rescue
            Media.create(@media)
          end
        end
      end
    rescue
    end
  end

end


