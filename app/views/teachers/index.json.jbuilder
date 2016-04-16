json.array!(@teachers) do |teacher|
  json.extract! teacher, :id, :school_id, :name, :registration_number, :phone, :email, :address
  json.url teacher_url(teacher, format: :json)
end
