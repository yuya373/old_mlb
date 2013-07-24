require 'spec_helper'

describe Atbat do
  fixtures :atbat

  it {should belong_to(:pitcher)}
  it {should belong_to(:batter)}
  it {should have_many(:pitchings)}

  describe "self.get" do
  end
end
