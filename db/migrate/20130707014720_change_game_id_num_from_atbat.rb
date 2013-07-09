class ChangeGameIdNumFromAtbat < ActiveRecord::Migration
  def change
    change_column :atbats, :game_id_num, :text
  end
end
