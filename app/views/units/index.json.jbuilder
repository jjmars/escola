json.array!(@units) do |unit|
  json.extract! unit, :id, :school_id, :title, :phone, :address
  json.url unit_url(unit, format: :json)
end
