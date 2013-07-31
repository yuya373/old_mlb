class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :game_id
      t.string :home_team_id
      t.string :away_team_id
      t.string :media_type
      t.string :date
      t.string :headline
      t.string :duration
      t.string :thumb
      t.string :url
      t.timestamps
    end
  end
end
