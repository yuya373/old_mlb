class AddCsToBatters < ActiveRecord::Migration
  def change
    add_column :batters, :month_cs, :integer
    add_column :batters, :empty_cs, :integer
    add_column :batters, :risp_cs, :integer
    add_column :batters, :men_on_cs, :integer
    add_column :batters, :loaded_cs, :integer
    add_column :batters, :vs_lhp, :integer
    add_column :batters, :vs_rhp, :integer
  end
end
