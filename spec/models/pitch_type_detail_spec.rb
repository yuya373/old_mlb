require 'spec_helper'

describe PitchTypeDetail do
  it {should have_db_index([:p_id_ty,:p_b])}
  it {should have_db_index([:p_id,:p_b])}
  it {should belong_to(:pitcher)}
  it {should belong_to(:batter)}
end
