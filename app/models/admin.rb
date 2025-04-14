class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include PasswordRequirements

  ROLE = "Admin".freeze

  def role
    ROLE
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
