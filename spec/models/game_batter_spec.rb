require 'spec_helper'

describe GameBatter do
  it {should belong_to(:game)}
  it {should have_db_index(:game_id)}
end
