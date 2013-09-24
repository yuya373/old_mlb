class ChangeTpIpFromPitchers < ActiveRecord::Migration
  def change
    change_column :teams, :tp_ip, :float
  end
end
