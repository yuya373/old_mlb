class AddLgRlgTpaToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :lg_r, :integer
    add_column :teams, :lg_tpa, :integer
  end
end
