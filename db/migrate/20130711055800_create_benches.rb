class CreateBenches < ActiveRecord::Migration
  def change
    create_table :benches do |t|
      t.string :game_id
      t.integer :team
      t.integer :p_id


      t.timestamps
    end
  end
end
