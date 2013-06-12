class AddColumnsToTeams < ActiveRecord::Migration
  def change
    rename_column :teams, :name, :team_name
    remove_columns :teams, :division, :fname
    add_column :teams, :team_abbrev, :string
    add_column :teams, :tb_h, :integer
    add_column :teams, :tb_ab, :integer
    add_column :teams, :tb_tb, :integer
    add_column :teams, :tb_avg, :float
    add_column :teams, :tb_slg, :float
    add_column :teams, :tb_g, :integer
    add_column :teams, :tb_r, :integer
    add_column :teams, :tb_b2, :integer
    add_column :teams, :tb_b3, :integer
    add_column :teams, :tb_hr, :integer
    add_column :teams, :tb_rbi, :integer
    add_column :teams, :tb_sac, :integer
    add_column :teams, :tb_sf, :integer
    add_column :teams, :tb_hbp, :integer
    add_column :teams, :tb_bb, :integer
    add_column :teams, :tb_ibb, :integer
    add_column :teams, :tb_so, :integer
    add_column :teams, :tb_sb, :integer
    add_column :teams, :tb_cs, :integer
      add_column :teams, :tb_gidp, :integer
    add_column :teams, :tb_obp, :float
    add_column :teams, :tb_ops, :float
    add_column :teams, :tp_ip, :integer
    add_column :teams, :tp_er, :integer
    add_column :teams, :tp_era, :float
    add_column :teams, :tp_whip, :float
    add_column :teams, :tp_h, :integer
    add_column :teams, :tp_r, :integer
    add_column :teams, :tp_hr, :integer
    add_column :teams, :tp_hb, :integer
    add_column :teams, :tp_bb, :integer
    add_column :teams, :tp_ibb, :integer
    add_column :teams, :tp_so, :integer
    add_column :teams, :tp_wp, :integer
    add_column :teams, :tp_g, :integer
    add_column :teams, :tp_gs, :integer
    add_column :teams, :tp_w, :integer
    add_column :teams, :tp_l, :integer
    add_column :teams, :tp_cg, :integer
    add_column :teams, :tp_gf, :integer
    add_column :teams, :tp_sho, :integer
    add_column :teams, :tp_sv, :integer
    add_column :teams, :tp_bsv, :integer
    add_column :teams, :tp_svo, :integer



  end
end
