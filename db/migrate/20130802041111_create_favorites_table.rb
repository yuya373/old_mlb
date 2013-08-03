class CreateFavoritesTable < ActiveRecord::Migration
  def change
    create_table :favorites_tables do |t|
      t.integer :team_id
      t.integer :p_id
      t.integer :user_id
      t.timestamps
    end
  end
end
