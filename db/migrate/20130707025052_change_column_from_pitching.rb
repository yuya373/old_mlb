class ChangeColumnFromPitching < ActiveRecord::Migration
  def change
    change_column :atbats, :game_id_num, :string
  end
end
