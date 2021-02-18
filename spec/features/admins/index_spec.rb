require 'rails_helper'

RSpec.describe 'Admins index page' do
  before :each do
    @app_1 = create(:application, reason: "I need friends.", names_of_pets: "Buddy, Goofy")
    @app_2 = create(:application, name: "John Doe, Jr.", names_of_pets: "Zeus")
    @app_3 = create(:application, name: "Jane Doe", names_of_pets: "Goofy")
    @app_4 = create(:application)
    @app_5 = create(:application, application_status: "Pending")
    @app_6 = create(:application)
    @dog_1 = create(:pet)
    @dog_2 = create(:pet, name: "Zeus")
    @dog_3 = create(:pet, name: "Goofy")
    @dog_4 = create(:pet, name: "Zeeb")
    @dog_5 = create(:pet, name: "Zeel")
    @shelter_1 = create(:shelter)
    @shelter_2 = create(:shelter, name: "" )
    @app_1_dog_1 = PetApplication.create!(application: @app_1, pet: @dog_1)
    @app_1_dog_3 = PetApplication.create!(application: @app_1, pet: @dog_3)
    @app_2_dog_2 = PetApplication.create!(application: @app_2, pet: @dog_2)
    @app_3_dog_1 = PetApplication.create!(application: @app_3, pet: @dog_1)
    @app_3_dog_2 = PetApplication.create!(application: @app_3, pet: @dog_2)
    @app_3_dog_3 = PetApplication.create!(application: @app_3, pet: @dog_3)
    @app_4_dog_1 = PetApplication.create!(application: @app_4, pet: @dog_1)
    @app_4_dog_2 = PetApplication.create!(application: @app_4, pet: @dog_2)
    @app_4_dog_3 = PetApplication.create!(application: @app_4, pet: @dog_3)
    @app_5_dog_3 = PetApplication.create!(application: @app_5, pet: @dog_3)
    @app_5_dog_4 = PetApplication.create!(application: @app_5, pet: @dog_4)
    @app_5_dog_5 = PetApplication.create!(application: @app_5, pet: @dog_5)
  end

  it "displaces all shelters in the system in reverse alphabetical order" do
    visit "/admin/applicants/#{@app_1.id}"

    expect(page).to have_content("Pet Name: #{@dog_1.name}")
    expect(page).to have_content("Pet Name: #{@dog_3.name}")

    within("#pet-#{@dog_1.id}") do
      expect(page).to have_button("Approve")
    end

    within("#pet-#{@dog_3.id}") do
      expect(page).to have_button("Approve")
    end

    find(id: "Approve#{@dog_1.id}").click
    find(id: "Approve#{@dog_3.id}").click
  end
