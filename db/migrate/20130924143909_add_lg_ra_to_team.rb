class AddLgRaToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :lg_ra, :float
  end
end
