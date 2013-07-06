class CreatePitchTypeDetails < ActiveRecord::Migration
  def change
    create_table :pitch_type_details do |t|
      t.string   "p_b"
      t.string   "p_id_ty"
      t.integer  "p_id"
      t.string   "pitch_type"
      t.string   "ab"
      t.float    "avg"
      t.integer  "hr"
      t.integer  "rbi"
      t.integer  "bb"
      t.integer  "so"
      t.float    "ops"
      t.string   "rating"
      t.string   "sweetness"
      t.timestamps
    end
  end
end
