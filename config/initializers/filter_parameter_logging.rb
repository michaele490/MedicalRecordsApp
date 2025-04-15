# Be sure to restart your server when you modify this file.

# Configure parameters to be partially matched (e.g. passw matches password) and filtered from the log file.
# Use this to limit dissemination of sensitive information.
# See the ActiveSupport::ParameterFilter documentation for supported notations and behaviors.
Rails.application.config.filter_parameters += [
  # Default sensitive parameters
  :passw, :email, :secret, :token, :_key, :crypt, :salt, :certificate, :otp, :ssn,
  
  # Personal identification information
  :first_name, :last_name, :dob, :phone_number,
  :emergency_contact_first_name, :emergency_contact_last_name, 
  :emergency_contact_phone_number,
  
  # Sensitive medical information
  :diagnosis, :treatment, :next_appointment_date,
  
  # Additional security parameters
  :remember_token, :reset_password_token, :confirmation_token,
  :unlock_token, :authentication_token
]
