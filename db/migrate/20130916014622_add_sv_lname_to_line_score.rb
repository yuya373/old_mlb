class AddSvLnameToLineScore < ActiveRecord::Migration
  def change
    add_column :line_scores, :sv_lname, :string
    add_column :line_scores, :sv_fname, :string
  end
end
