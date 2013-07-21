class AddTestToExample < ActiveRecord::Migration
  def change
    add_column :examples, :test, :string
  end
end
