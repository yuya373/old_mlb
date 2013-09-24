class AddLgFipToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :lg_fip, :float
  end
end
