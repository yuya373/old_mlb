class AddlhpCsToBatters < ActiveRecord::Migration
  def change
    add_column :batters, :vs_rhp_cs, :integer
    add_column :batters, :vs_lhp_cs, :integer
  end
end
