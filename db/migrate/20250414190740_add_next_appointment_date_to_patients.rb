class AddNextAppointmentDateToPatients < ActiveRecord::Migration[7.2]
  def change
    add_column :patients, :next_appointment_date, :date
  end
end
