class AddColumnToLineScore < ActiveRecord::Migration
  def change
    add_column :line_scores, :wp_id, :integer
    add_column :line_scores, :wp_name, :string
    add_column :line_scores, :wp_w, :integer
    add_column :line_scores, :wp_l, :integer
    add_column :line_scores, :wp_era, :float
    add_column :line_scores, :lp_id, :integer
    add_column :line_scores, :lp_name, :string
    add_column :line_scores, :lp_w, :integer
    add_column :line_scores, :lp_l, :integer
    add_column :line_scores, :lp_era, :float
    add_column :line_scores, :sv_id, :integer
    add_column :line_scores, :sv_name, :string
    add_column :line_scores, :sv_w, :integer
    add_column :line_scores, :sv_l, :integer
    add_column :line_scores, :sv_era, :float
    add_column :line_scores, :sv_sv, :integer
  end
end
