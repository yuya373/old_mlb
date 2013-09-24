class AddTpFipToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :tp_fip, :float
  end
end
