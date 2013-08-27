class AddPIdToMedia < ActiveRecord::Migration
  def change
    add_column :media, :p_id, :integer
    add_column :media, :team_id, :integer
    change_column :media, :date, :date
  end
end
