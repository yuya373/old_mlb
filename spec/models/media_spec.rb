require 'spec_helper'

describe Media do
  it {should belong_to(:game)}
  it {should belong_to(:pitcher)}
  it {should belong_to(:batter)}
  it {should belong_to(:team)}
  describe "#self.get" do

  end
end
