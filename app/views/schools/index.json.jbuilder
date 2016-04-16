json.array!(@schools) do |school|
  json.extract! school, :id, :title, :cnpj, :phone, :address
  json.url school_url(school, format: :json)
end
