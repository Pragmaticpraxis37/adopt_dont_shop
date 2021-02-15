require 'rails_helper'

RSpec.describe 'Applications show page' do
  before :each do
    @app_1 = create(:application)
    @app_2 = create(:application, name: "John Doe, Jr.", names_of_pets: "Zeus")
    @app_3 = create(:application, name: "Jane Doe", names_of_pets: "Goofy")
    @dog_1 = create(:pet)
    @dog_2 = create(:pet, name: "Zeus")
    @dog_3 = create(:pet, name: "Goofy")
    @dog_4 = create(:pet, name: "Zeeb")
    @dog_5 = create(:pet, name: "Zeel")
    @shelter_1 = create(:shelter)
    @app_1_dog_1 = PetApplication.create!(application: @app_1, pet: @dog_1)
    @app_1_dog_3 = PetApplication.create!(application: @app_1, pet: @dog_3)
    @app_2_dog_2 = PetApplication.create!(application: @app_2, pet: @dog_2)
    @app_2_dog_3 = PetApplication.create!(application: @app_2, pet: @dog_3)
  end

  it "displays an applicant with corresponding id and attributes" do
    visit "/applicants/#{@app_1.id}"

    expect(page).to have_content("Name: #{@app_1.name}")
    expect(page).to have_content("Address: #{@app_1.address}")
    expect(page).to have_content("City: #{@app_1.city}")
    expect(page).to have_content("State: #{@app_1.state}")
    expect(page).to have_content("Zip: #{@app_1.zip}")
    expect(page).to have_content("Reason for Adoption: #{@app_1.reason}")
    expect(page).to have_content("Application Status: #{@app_1.application_status}")
  end

  it "displays a link for the pet's show page and the link takes you to the pet's show page" do
    visit "/applicants/#{@app_2.id}"

    expect(page).to_not have_link "#{@dog_1.name}", href: "/pets/#{@dog_1.id}"
    expect(page).to have_link "#{@dog_2.name}", href: "/pets/#{@dog_2.id}"
    expect(page).to have_link "#{@dog_3.name}", href: "/pets/#{@dog_3.id}"

    click_link "#{@dog_2.name}", href: "/pets/#{@dog_2.id}"

    expect(page).to have_content(@dog_2.name)
  end

  it "allows a pet to be searched for by name" do
    visit "/applicants/#{@app_1.id}"

    expect(page).to have_field("Add a Pet to this Application")
    expect(page).to have_button("Submit")
    fill_in :query, with: "Ze"

    click_on "Submit"

    expect(current_path).to eq("/applicants/#{@app_1.id}")
    # save_and_open_page

    expect(page).to have_content("Zeus")
    expect(page).to have_content("Zeeb")
    expect(page).to have_content("Zeel")

    fill_in :query, with: "Zee"

    click_on "Submit"

    expect(page).to have_content("Zeeb")
    expect(page).to have_content("Zeel")

    fill_in :query, with: "Zeel"

    click_on "Submit"

    expect(page).to have_content("Zeel")

    fill_in :query, with: "ZEEL"

    click_on "Submit"

    expect(page).to have_content("Zeel")
  end
end
