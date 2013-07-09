class AddWinpctToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :win_pct, :float
  end
end
