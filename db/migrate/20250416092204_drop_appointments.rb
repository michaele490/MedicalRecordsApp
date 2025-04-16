class DropAppointments < ActiveRecord::Migration[7.2]
  def up
    drop_table :appointments
  end

  def down
    create_table :appointments do |t|
      t.datetime :date
      t.string :notes
      t.string :name
      t.references :patient, null: false, foreign_key: true
      t.timestamps
    end
  end
end
