class AddWobasToBatter < ActiveRecord::Migration
  def change
    add_column :batters, :woba, :float
    add_column :batters, :wraa, :float
    add_column :batters, :wrc, :float
    add_column :batters, :wrc_plus, :float
    add_column :batters, :iso, :float
    add_column :batters, :k_pct, :float
    add_column :batters, :bb_pct, :float
    add_column :batters, :babip, :float
    add_column :batters, :spd, :float
  end
end
