require 'rails_helper'

RSpec.describe 'Admins index page' do
  before :each do
    @app_1 = create(:application)
    # @app_2 = create(:application, name: "John Doe, Jr.", names_of_pets: "Zeus")
    # @app_3 = create(:application, name: "Jane Doe", names_of_pets: "Goofy")
    # @app_4 = create(:application)
    # @app_5 = create(:application, application_status: "Pending")
    # @app_6 = create(:application)
    # @dog_1 = create(:pet)
    # @dog_2 = create(:pet, name: "Zeus")
    # @dog_3 = create(:pet, name: "Goofy")
    # @dog_4 = create(:pet, name: "Zeeb")
    # @dog_5 = create(:pet, name: "Zeel")
    @shelter_2 = create(:shelter, name: "A Shelter")
    @shelter_3 = create(:shelter, name: "Big Shelter")
    @shelter_4 = create(:shelter, name: "City Shelter")
    @shelter_5 = create(:shelter, name: "Dog Shelter")
    @dog_1 = @shelter_2.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @dog_2 = @shelter_2.pets.create!(image:"", name: "Loki", description: "dog", approximate_age: 2, sex: "male")
    @app_1_dog_1 = PetApplication.create!(application: @app_1, pet: @dog_1)
    # @app_1_dog_1 = PetApplication.create!(application: @app_1, pet: @dog_1)
    # @app_1_dog_3 = PetApplication.create!(application: @app_1, pet: @dog_3)
    # @app_2_dog_2 = PetApplication.create!(application: @app_2, pet: @dog_2)
    # @app_3_dog_1 = PetApplication.create!(application: @app_3, pet: @dog_1)
    # @app_3_dog_2 = PetApplication.create!(application: @app_3, pet: @dog_2)
    # @app_3_dog_3 = PetApplication.create!(application: @app_3, pet: @dog_3)
    # @app_4_dog_1 = PetApplication.create!(application: @app_4, pet: @dog_1)
    # @app_4_dog_2 = PetApplication.create!(application: @app_4, pet: @dog_2)
    # @app_4_dog_3 = PetApplication.create!(application: @app_4, pet: @dog_3)
    # @app_5_dog_3 = PetApplication.create!(application: @app_5, pet: @dog_3)
    # @app_5_dog_4 = PetApplication.create!(application: @app_5, pet: @dog_4)
    # @app_5_dog_5 = PetApplication.create!(application: @app_5, pet: @dog_5)
  end

  skip "displays all shelters in the system in reverse alphabetical order" do
    visit "/admin/shelters"

    within("#shelter-#{@shelter_5.id}") do
      expect(page).to have_content(@shelter_5.name)
      # expect(page).to have_content(@shelter_4.name)
      # expect(page).to have_content(@shelter_3.name)
      # expect(page).to have_content(@shelter_2.name)
    end
  end

  it "displays the shelter's name and full address" do
    visit "/admin/shelters/#{@shelter_2.id}"

    expect(page).to have_content("A Shelter")


  end
end
