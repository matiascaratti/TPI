class Professional < ApplicationRecord
    has_many :appointments

    validates :name, presence: true, uniqueness: true
    validates :phone, presence: true
    validates :email, presence: true
    validates :specialty, presence: true
end
