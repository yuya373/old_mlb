require 'open-uri'
require 'csv'
class Team < ActiveRecord::Base
  self.primary_key = 'team_id'
  has_many :batters, :foreign_key => 'team_id'
  has_many :pitchers, :foreign_key => 'team_id'
  has_many :home_team_game, :foreign_key => 'home_team_id', :class_name => 'Game'
  has_many :away_team_game, :foreign_key => 'away_team_id', :class_name => 'Game'
  has_many :team_favorites
  has_many :medias


  scope :division, lambda{|division| where(division: division)}
  scope :stats, lambda{|item,direction| order(item + ' ' + direction)}
  scope :al, lambda{where('league_id = 103')}
  scope :nl, lambda{where('league_id = 104')}
  scope :batting, lambda{select('team_name,team_id,tb_g,tb_ab,tb_r,tb_tb,tb_h,tb_b2,tb_b3,tb_hr,tb_rbi,tb_sac,tb_sf,tb_bb,tb_ibb,tb_so,tb_sb,tb_cs,tb_gidp,tb_avg,tb_obp,tb_slg,tb_ops,updated_at')}
  scope :pitching, lambda{select('team_name,team_id,tp_w,tp_l,tp_era,tp_g,tp_gs,tp_sv,tp_bsv,tp_svo,tp_ip,tp_h,tp_r,tp_er,tp_hr,tp_bb,tp_wp,tp_so,tp_cg,tp_gf,tp_sho,tp_whip,updated_at')}
  scope :order_by_win_pct ,lambda{order('win_pct desc')}

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
      @team[:game_id] = team_stats.attribute('game_id').text.tr('/','_').tr('-','_')



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
    CSV.open("team.csv","wb", headers: true) do |csv|
      att = Team.attribute_names
      att.delete("id")
      att.delete("created_at")
      att.delete("updated_at")

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

  def self.lg_stats
    al_ip = Team.al.sum(:tp_ip)
    al_er = Team.al.sum(:tp_er)
    al_hr = Team.al.sum(:tp_hr)
    al_bb = Team.al.sum(:tp_bb)
    al_hb = Team.al.sum(:tp_hb)
    al_ibb = Team.al.sum(:tp_ibb)
    al_so = Team.al.sum(:tp_so)
    al_r = Team.al.sum(:tp_r)
    al_era = (al_er.to_f / al_ip.to_f) * 9
    al_ra = (al_r.to_f / al_ip.to_f) * 9

    Team.al.each do |team|
      team_fip = team.pitchers.average(:fip)

      team_woba = team.batters.average(:woba)

      team.update_attributes(tp_fip: team_fip, tb_woba: team_woba)
    end

    al_fip = Team.al.average(:tp_fip)
    al_woba = Team.al.average(:tb_woba)

    Team.al.update_all(
      lg_era: al_era,
      lg_hr: al_hr,
      lg_bb: al_bb,
      lg_hb: al_hb,
      lg_ibb: al_ibb,
      lg_so: al_so,
      lg_ip: al_ip,
      lg_er: al_er,
      lg_fip: al_fip,
      lg_ra: al_ra,
      lg_woba: al_woba
      )

    nl_ip = Team.nl.sum(:tp_ip)
    nl_er = Team.nl.sum(:tp_er)
    nl_hr = Team.nl.sum(:tp_hr)
    nl_bb = Team.nl.sum(:tp_bb)
    nl_hb = Team.nl.sum(:tp_hb)
    nl_ibb = Team.nl.sum(:tp_ibb)
    nl_so = Team.nl.sum(:tp_so)
    nl_r = Team.nl.sum(:tp_r)
    nl_era = (nl_er.to_f / nl_ip.to_f) * 9
    nl_ra = (nl_r.to_f / nl_ip.to_f) * 9

    Team.nl.each do |team|
      team_fip = team.pitchers.average(:fip)

      team_woba = team.batters.average(:woba)

      team.update_attributes(tp_fip: team_fip, tb_woba: team_woba)
    end

    nl_fip = Team.nl.average(:tp_fip)
    nl_woba = Team.nl.average(:tb_woba)

    Team.nl.update_all(
      lg_era: nl_era,
      lg_hr: nl_hr,
      lg_bb: nl_bb,
      lg_hb: nl_hb,
      lg_ibb: nl_ibb,
      lg_so: nl_so,
      lg_ip: nl_ip,
      lg_er: nl_er,
      lg_fip: nl_fip,
      lg_ra: nl_ra,
      lg_woba: nl_woba
      )
  end
end
