require 'open-uri'
require 'csv'
class Team < ActiveRecord::Base
  self.primary_key = 'team_id'
  has_many :batters, :primary_key => 'team_id'
  has_many :pitchers, :primary_key => 'team_id'

  scope :league_division, lambda{|team_id| where(:team_id => team_id).order('win_pct desc').select('team_name, team_id, tp_w, tp_l,win_pct')}
  def self.get
    team_id = [108,109,110,111,112,113,114,115,116,117,118,119,120,121,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,158]
    team_id.each do |t|
      url = "http://gd2.mlb.com/components/team/stats/#{t}-stats.xml"
      doc = Nokogiri::XML(open(url))
      @team = {}
      team_stats = doc.css('TeamStats')
      @team[:team_name] = team_stats.attribute('team_name').text
      @team[:team_id] = team_stats.attribute('team_id').text
      @team[:league_id] = team_stats.attribute('league_id').text
      @team[:team_abbrev] = team_stats.attribute('team_abbrev').text
      @team[:game_id] = team_stats.attribute('game_id').text



      #チーム打撃成績
      team_batting = team_stats.children[0]
      team_batting.each do |k,v|
        key = "tb_#{k.downcase}"
          @team[key.to_sym] = v
      end

      #チーム投球成績
      team_pitching = team_stats.children[1]
      team_pitching.each do |k,v|
        key = "tp_#{k.downcase}"
        @team[key.to_sym] = v
      end
      @team[:win_pct] = @team[:tp_w].to_f/@team[:tp_g].to_f
      team_id = @team[:team_id]

      begin
        Team.where('team_id = ?', team_id).first.update_attributes!(@team)
      rescue
        Team.create(@team)
      end
    end
  end

  def self.csv
    CSV.open("team.csv","wb") do |csv|
      att = Team.attribute_names
      csv << att

      Team.find_each do |team|
        col = []
        att.each do |att|
          col << "#{team[att.to_sym]}"
        end

        csv << col
      end
    end

  end
end
