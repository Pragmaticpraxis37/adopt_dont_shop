class ChangePPetApplicationsToPetApplications < ActiveRecord::Migration[5.2]
  def change
    rename_table :p_pet_applications, :pet_applications  
  end
end
