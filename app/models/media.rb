require 'open-uri'

class Media < ActiveRecord::Base

  belongs_to :game, :foreign_key => 'game_id'
  def self.get
    date = Date.yesterday.to_s
    year = date.slice(0,4)
    month = date.slice(5,2)
    day = date.slice(8,2)

    url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/media/highlights.xml"
    begin
      doc = Nokogiri::XML(open(url))

      highlights = doc.css('highlights')

      highlights.each do |high|
        high.css('media').each do |media|
          home_team_id = high.attribute('home_team_id').text
          away_team_id = high.attribute('away_team_id').text
          game_id = high.attribute('id').text.tr('/','_')


          media_type = media.attribute('type').text
          date = media.attribute('date').text
          headline = media.css('headline').text
          duration = media.css('duration').text

          thumb = media.css('thumb').text

          url = media.css('url').text
          keyword = media.css('keyword')[0]
          sv_id = keyword.attribute('value').text

          @media = {
            home_team_id: home_team_id,
            away_team_id: away_team_id,
            game_id: game_id,
            media_type: media_type,
            date: date,
            thumb: thumb,
            url: url,
            sv_id: sv_id,
            headline: headline,
            duration: duration
          }
          begin
            Media.where(sv_id: @media[:sv_id]).first.update_attributes!(@media)
          rescue
            Media.create(@media)
          end
        end
      end
    rescue
    end
  end

  def self.seed(year,month,day)

    url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/media/highlights.xml"
    begin
      doc = Nokogiri::XML(open(url))

      highlights = doc.css('highlights')

      highlights.each do |high|
        high.css('media').each do |media|
          home_team_id = high.attribute('home_team_id').text
          away_team_id = high.attribute('away_team_id').text
          game_id = high.attribute('id').text.tr('/','_')


          media_type = media.attribute('type').text
          date = media.attribute('date').text
          headline = media.css('headline').text
          duration = media.css('duration').text

          thumb = media.css('thumb').text

          url = media.css('url').text
          keyword = media.css('keyword')[0]
          sv_id = keyword.attribute('value').text

          @media = {
            home_team_id: home_team_id,
            away_team_id: away_team_id,
            game_id: game_id,
            media_type: media_type,
            date: date,
            thumb: thumb,
            url: url,
            sv_id: sv_id,
            headline: headline,
            duration: duration
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
              game_id: gid,
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
            game_id: "#{year}_#{month}_#{day}_#{away_team}-#{home_team}-#{num}"
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


