require 'spec_helper'

describe Team do
  it {should have_many(:batters)}
  it {should have_many(:pitchers)}
  it {should have_db_index(:team_id)}

end
