class CreatePitchings < ActiveRecord::Migration
  def change
    create_table :pitchings do |t|

      t.timestamps
    end
  end
end
