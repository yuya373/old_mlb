class AddFnameLnameToLinescore < ActiveRecord::Migration
  def change
    add_column :line_scores, :wp_fname, :string
    add_column :line_scores, :lp_fname, :string
    add_column :line_scores, :wp_lname, :string
    add_column :line_scores, :lp_lname, :string
  end
end
