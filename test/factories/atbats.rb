# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :atbat do
    num 1
    b 1
    s 1
    o 1
    start_tfs 1
    start_tfs_zulu "MyString"
    batter_id 1
    pitcher_id 1
    stand "MyString"
    b_height "MyString"
    p_throws "MyString"
    des "MyText"
    event "MyString"
    game_id "MyString"
    game_id_num "MyString"
    pitcher_name "MyString"
    batter_name "MyString"
    batter_team "MyString"
    pitcher_team "MyString"
  end
end
