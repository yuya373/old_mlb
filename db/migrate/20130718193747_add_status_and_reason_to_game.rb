class AddStatusAndReasonToGame < ActiveRecord::Migration
  def change
    add_column :games, :status, :string
    add_column :games, :reason, :string
  end
end
