class Doctor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include PasswordRequirements

  ROLE = "Doctor".freeze

  def role
    ROLE
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
