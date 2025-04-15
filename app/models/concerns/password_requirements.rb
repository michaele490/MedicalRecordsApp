module PasswordRequirements
    extend ActiveSupport::Concern

    included do
      validate :password_requirements
    end

    private

    def password_requirements
      return if password.blank?

      unless password =~ /(?=.*[a-z])/
        errors.add :password, "must include at least one lowercase letter"
      end

      unless password =~ /(?=.*[A-Z])/
        errors.add :password, "must include at least one uppercase letter"
      end

      unless password =~ /(?=.*\d)/
        errors.add :password, "must include at least one numeric character"
      end
    end
end
