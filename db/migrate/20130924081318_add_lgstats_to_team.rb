class AddLgstatsToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :lg_hr, :integer
    add_column :teams, :lg_bb, :integer
    add_column :teams, :lg_hb, :integer
    add_column :teams, :lg_ibb, :integer
    add_column :teams, :lg_so, :integer
    add_column :teams, :lg_ip, :float
    add_column :teams, :lg_er, :integer
  end
end
