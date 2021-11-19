class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.date :datetime
      t.string :patient_name
      t.string :patient_surname
      t.string :patient_phone
      t.string :notes
      t.belongs_to :professional, null: false, foreign_key: true

      t.timestamps
    end
  end
end
