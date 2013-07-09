json.array!(@data) do |datum|
  json.extract! datum, :gid, :year, :month, :day, :team_name, :team_id
  json.url datum_url(datum, format: :json)
end