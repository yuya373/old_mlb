class AddOpsToBatters < ActiveRecord::Migration
  def change
    add_column :batters, :carrer_ops, :float
    add_column :batters, :month_ops, :float
    add_column :batters, :empty_ops, :float
    add_column :batters, :men_on_ops, :float
    add_column :batters, :risp_ops, :float
    add_column :batters, :loaded_ops, :float
    add_column :batters, :vs_lhp_ops, :float
    add_column :batters, :vs_rhp_ops, :float
  end
end
