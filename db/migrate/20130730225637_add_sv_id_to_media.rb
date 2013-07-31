class AddSvIdToMedia < ActiveRecord::Migration
  def change
    add_column :media, :sv_id, :string
  end
end
