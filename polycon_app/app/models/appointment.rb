class MinutesValidator < ActiveModel::Validator
  def validate(record)
      unless ((record.date.min == 0) or (record.date.min == 30))
          record.errors.add :base, "This appointment's date format is invalid"
      end
  end
end

class HourValidator < ActiveModel::Validator
  def validate(record)
      unless ((record.date.hour >= 8) and (record.date.hour <= 19))
          record.errors.add :base, "This appointment's date format is invalid"
      end
  end
end


class Appointment < ApplicationRecord
  belongs_to :professional
  validates :date, presence: true
  validates_with HourValidator
  validates_with MinutesValidator
  validates :patient_name, presence: true
  validates :patient_surname, presence: true
  validates :patient_phone, presence: true
  validates :professional_id, presence: true
  validates_uniqueness_of :professional_id, scope: :date 
end
