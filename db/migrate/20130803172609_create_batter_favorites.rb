class CreateBatterFavorites < ActiveRecord::Migration
  def change
    create_table :batter_favorites do |t|
      t.integer :batter_id
      t.integer :user_id

      t.timestamps
    end
  end
end
