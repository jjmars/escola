json.array!(@klasses) do |klass|
  json.extract! klass, :id, :school_id, :unit_id, :title
  json.url klass_url(klass, format: :json)
end
