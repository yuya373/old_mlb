class AddIndexToMedia < ActiveRecord::Migration

  def change
    add_index :media, :sv_id
    add_index :media, :game_id
  end
end
