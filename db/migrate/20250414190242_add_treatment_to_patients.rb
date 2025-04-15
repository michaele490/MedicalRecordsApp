class AddTreatmentToPatients < ActiveRecord::Migration[7.2]
  def change
    add_column :patients, :treatment, :text
  end
end
