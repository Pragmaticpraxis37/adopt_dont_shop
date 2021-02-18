class CreatePPetApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :p_pet_applications do |t|
      t.references :application, foreign_key: true
      t.references :pet, foreign_key: true
    end
  end
end
