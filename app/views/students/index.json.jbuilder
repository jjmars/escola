json.array!(@students) do |student|
  json.extract! student, :id, :school_id, :unit_id, :name, :registration_number, :phone, :email, :address
  json.url student_url(student, format: :json)
end
