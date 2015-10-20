json.array!(@trips) do |trip|
  json.extract! trip, :id, :title, :user_id, :about, :startDate, :endDate
  json.url trip_url(trip, format: :json)
end
