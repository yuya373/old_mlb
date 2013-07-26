require 'spec_helper'

describe Pitching do
  it {should belong_to(:pitcher)}
  it {should belong_to(:batter)}
  it {should belong_to(:atbat)}
  it {should have_db_index(:game_id_num_id)}
  it {should have_db_index(:game_id_num)}
  it {should have_db_index(:game_id)}
end
