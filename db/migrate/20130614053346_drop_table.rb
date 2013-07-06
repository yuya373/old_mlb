class DropTable < ActiveRecord::Migration
  def change
    drop_table :pitchings
  end
end
