class StaffController < ApplicationController
  before_action :admin_should_exist, only: [ :index ]
  before_action :authorize_admin!, only: [ :index ]
  def index
  end

  def admin_should_exist
    if Admin.count == 0
      redirect_to new_admin_registration_path, alert: "Please create an admin account first."
    end
  end
end
