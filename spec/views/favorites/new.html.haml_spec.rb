require 'spec_helper'

describe "favorites/new" do
  before(:each) do
    assign(:favorite, stub_model(Favorite,
      :team_id => 1,
      :p_id => 1,
      :user_id => 1
    ).as_new_record)
  end

  it "renders new favorite form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", favorites_path, "post" do
      assert_select "input#favorite_team_id[name=?]", "favorite[team_id]"
      assert_select "input#favorite_p_id[name=?]", "favorite[p_id]"
      assert_select "input#favorite_user_id[name=?]", "favorite[user_id]"
    end
  end
end
