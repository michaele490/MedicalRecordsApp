class CreatePatients < ActiveRecord::Migration[7.2]
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.boolean :is_alive
      t.string :emergency_contact_first_name
      t.string :emergency_contact_last_name
      t.string :emergency_contact_phone_number
      t.string :phone_number
      t.string :diagnosis

      t.timestamps
    end
  end
end
