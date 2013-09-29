class AddLgWobaToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :lg_woba, :float
  end
end
