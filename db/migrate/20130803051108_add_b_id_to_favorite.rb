class AddBIdToFavorite < ActiveRecord::Migration
  def change
    add_column :favorites, :b_id, :integer
  end
end
