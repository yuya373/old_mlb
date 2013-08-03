require 'spec_helper'

describe Pitcher do
  it {should belong_to(:team)}
  it {should have_many(:pitchings)}
  it {should have_many(:atbats)}
  it {should have_many(:pitch_type_details)}
  it {should have_many(:pitch_tendencies)}
  it {should validate_uniqueness_of(:p_id)}
  it {should have_db_index(:p_id)}
  it {should have_many(:pitcher_favorites)}
end
