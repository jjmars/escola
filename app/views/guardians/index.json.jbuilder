json.array!(@guardians) do |guardian|
  json.extract! guardian, :id, :school_id, :unit_id, :name, :phone, :email, :address
  json.url guardian_url(guardian, format: :json)
end
