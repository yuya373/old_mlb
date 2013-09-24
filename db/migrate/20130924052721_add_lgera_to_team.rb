class AddLgeraToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :lg_era, :float
  end
end
