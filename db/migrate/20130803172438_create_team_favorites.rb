class CreateTeamFavorites < ActiveRecord::Migration
  def change
    create_table :team_favorites do |t|
      t.integer :team_id
      t.integer :user_id

      t.timestamps
    end
  end
end
