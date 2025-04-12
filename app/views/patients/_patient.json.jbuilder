json.extract! patient, :id, :first_name, :last_name, :dob, :is_alive, :emergency_contact_first_name, :emergency_contact_last_name, :emergency_contact_phone_number, :phone_number, :diagnosis, :created_at, :updated_at
json.url patient_url(patient, format: :json)
