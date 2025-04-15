class Patient < ApplicationRecord
  encrypts :diagnosis
  encrypts :treatment

  def full_name
    "#{first_name} #{last_name}"
  end

  def emergency_contact_full_name
    "#{emergency_contact_first_name} #{emergency_contact_last_name}"
  end
end
