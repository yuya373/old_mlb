class CreatePitcherFavorites < ActiveRecord::Migration
  def change
    create_table :pitcher_favorites do |t|
      t.integer :p_id
      t.integer :user_id

      t.timestamps
    end
  end
end
