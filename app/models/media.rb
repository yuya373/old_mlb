require 'open-uri'

class Media < ActiveRecord::Base

  belongs_to :game, :foreign_key => 'game_id'
  def self.get
    date = Date.yesterday.to_s
    year = date.slice(0,4)
    month = date.slice(5,2)
    day = date.slice(8,2)

    url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/media/highlights.xml"

    doc = Nokogiri::XML(open(url))

    highlights = doc.css('highlights')

    highlights.each do |high|
      high.css('media').each do |media|
        home_team_id = high.attribute('home_team_id').text
        away_team_id = high.attribute('away_team_id').text
        game_id = high.attribute('id').text


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
          game_id = high.attribute('id').text


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
end
