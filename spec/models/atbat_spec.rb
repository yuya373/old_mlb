require 'spec_helper'

describe Atbat do
  fixtures :atbat

  it {should belong_to(:pitcher)}
  it {should belong_to(:batter)}
  it {should belong_to(:game)}
  it {should have_many(:pitchings)}
  it {should validate_uniqueness_of(:game_id_num)}
  it {should have_db_index(:game_id)}
  it {should have_db_index(:game_id_num)}
  it {should have_db_index(:batter_id)}
  it {should have_db_index(:pitcher_id)}
  it {should have_db_index(:batter_name)}
  it {should have_db_index(:pitcher_name)}

  describe "self.get" do
  end
end
