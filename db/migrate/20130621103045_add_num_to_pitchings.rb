class AddNumToPitchings < ActiveRecord::Migration
  def change
    add_column :pitchings, :num, :string
  end
end
