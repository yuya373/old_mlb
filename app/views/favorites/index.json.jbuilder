json.array!(@favorites) do |favorite|
  json.extract! favorite, :team_id, :p_id, :user_id
  json.url favorite_url(favorite, format: :json)
end