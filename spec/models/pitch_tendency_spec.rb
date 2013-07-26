require 'spec_helper'

describe PitchTendency do

  it {should have_db_index(:p_id)}
  it {should have_db_index([:game_id,:p_id,:pitch_type])}
  it {should belong_to(:pitcher)}
end
