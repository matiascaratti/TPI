class Appointment < ApplicationRecord
  belongs_to :professional
  validates :date, presence: true
  validates :patient_name, presence: true
  validates :patient_surname, presence: true
  validates :patient_phone, presence: true
end
