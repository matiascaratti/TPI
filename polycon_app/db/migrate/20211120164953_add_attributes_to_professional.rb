class AddAttributesToProfessional < ActiveRecord::Migration[6.1]
  def change
    add_column :professionals, :phone, :string
    add_column :professionals, :email, :string
    add_column :professionals, :specialty, :string
  end
end
