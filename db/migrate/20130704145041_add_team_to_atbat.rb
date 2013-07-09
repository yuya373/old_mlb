class AddTeamToAtbat < ActiveRecord::Migration
  def change
    add_column :atbats, :batter_team, :string
    add_column :atbats, :pitcher_team, :string
  end
end
