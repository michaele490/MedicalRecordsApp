# Generate a random key for encryption
require 'securerandom'

Rails.application.config.active_record.encryption.configure(
  primary_key: SecureRandom.hex(32),
  deterministic_key: SecureRandom.hex(32),
  key_derivation_salt: SecureRandom.hex(32)
) 