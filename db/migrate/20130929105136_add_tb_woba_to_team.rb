class AddTbWobaToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :tb_woba, :float
  end
end
