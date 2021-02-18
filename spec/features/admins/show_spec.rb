require 'rails_helper'

RSpec.describe 'Admins show page' do
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

  it "displays an approve button for each pet on the application" do
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

  it "when the approve button for a pet is clicked, the admin application page
     is shown again with the button gone next to the pet and an indicator it has
     has been approved" do

    visit "/admin/applicants/#{@app_3.id}"

    expect(page).to have_content("Pet Name: #{@dog_1.name}")
    expect(page).to have_content("Pet Name: #{@dog_2.name}")
    expect(page).to have_content("Pet Name: #{@dog_3.name}")

    find(id: "Approve#{@dog_2.id}").click
    find(id: "Approve#{@dog_3.id}").click

    within("#pet-#{@dog_1.id}") do
      expect(page).to have_button("Approve")
    end
    expect(page).to have_content("Pet Name: #{@dog_2.name} Approved")
    expect(page).to have_content("Pet Name: #{@dog_3.name} Approved")
  end

  it "when the reject button for a pet is clicked, the admin application page
     is shown again with the button gone next to the pet and an indicator it has
     has been rejected" do

    visit "/admin/applicants/#{@app_3.id}"

    expect(page).to have_content("Pet Name: #{@dog_1.name}")
    expect(page).to have_content("Pet Name: #{@dog_2.name}")
    expect(page).to have_content("Pet Name: #{@dog_3.name}")

    find(id: "Reject#{@dog_1.id}").click
    find(id: "Reject#{@dog_3.id}").click

    within("#pet-#{@dog_2.id}") do
      expect(page).to have_button("Reject")
    end
    expect(page).to have_content("Pet Name: #{@dog_1.name} Rejected")
    expect(page).to have_content("Pet Name: #{@dog_3.name} Rejected")
  end

  it "when a pet is approved or rejected on one application it doesn't affect
     the other application's pets' statuses" do

    visit "/admin/applicants/#{@app_3.id}"

    expect(page).to have_content("Pet Name: #{@dog_1.name}")
    expect(page).to have_content("Pet Name: #{@dog_2.name}")
    expect(page).to have_content("Pet Name: #{@dog_3.name}")

    find(id: "Reject#{@dog_1.id}").click
    find(id: "Reject#{@dog_3.id}").click

    within("#pet-#{@dog_2.id}") do
      expect(page).to have_button("Approve")
    end
    within("#pet-#{@dog_2.id}") do
      expect(page).to have_button("Reject")
    end
    expect(page).to have_content("Pet Name: #{@dog_1.name} Rejected")
    expect(page).to have_content("Pet Name: #{@dog_3.name} Rejected")

    visit "/admin/applicants/#{@app_4.id}"

    expect(page).to have_content("Pet Name: #{@dog_1.name}")
    expect(page).to have_content("Pet Name: #{@dog_2.name}")
    expect(page).to have_content("Pet Name: #{@dog_3.name}")

    within("#pet-#{@dog_1.id}") do
      expect(page).to have_button("Approve")
    end
    within("#pet-#{@dog_1.id}") do
      expect(page).to have_button("Reject")
    end

    within("#pet-#{@dog_2.id}") do
      expect(page).to have_button("Approve")
    end
    within("#pet-#{@dog_2.id}") do
      expect(page).to have_button("Reject")
    end

    within("#pet-#{@dog_3.id}") do
      expect(page).to have_button("Approve")
    end
    within("#pet-#{@dog_3.id}") do
      expect(page).to have_button("Reject")
    end
  end

  it "when all pets are approved on an application, the application's status has
    changed to approved" do

    visit "/admin/applicants/#{@app_5.id}"

    find(id: "Reject#{@dog_3.id}").click
    find(id: "Reject#{@dog_4.id}").click
    find(id: "Approve#{@dog_5.id}").click

    expect(page).to have_content("Application Status is Rejected")
  end

  it "when all pets are approved on an application, the application's status has
    changed to approved" do

    visit "/admin/applicants/#{@app_5.id}"

    find(id: "Approve#{@dog_3.id}").click
    find(id: "Approve#{@dog_4.id}").click
    find(id: "Approve#{@dog_5.id}").click

    expect(page).to have_content("Application Status is Accepted")
  end

  it "when all pets are approved on an application, the pets listed in the application
     have their adoptable status changed to non-adoptable" do

    visit "/admin/applicants/#{@app_5.id}"

    find(id: "Approve#{@dog_3.id}").click
    find(id: "Approve#{@dog_4.id}").click
    find(id: "Approve#{@dog_5.id}").click

    save_and_open_page

    expect(page).to have_content("Application Status is Accepted")
  end
end
