require 'rails_helper'

RSpec.describe 'Applications show page' do
  before :each do
    @app_1 = create(:application)
    @app_2 = create(:application, name: "John Doe, Jr.", names_of_pets: "Zeus")
    @app_3 = create(:application, name: "Jane Doe", names_of_pets: "Goofy")
    @app_4 = create(:application)
    @app_5 = create(:application)
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

  it "allows a found pet to be added to the application" do
    visit "/applicants/#{@app_4.id}"

    fill_in :query, with: "Goofy"

    click_on "Submit"

    expect(current_path).to eq("/applicants/#{@app_4.id}")

    expect(page).to have_content("Goofy")

    click_on "Adopt this Pet", id: @dog_3.id

    expect(page).to have_link "#{@dog_3.name}", href: "/pets/#{@dog_3.id}"


    visit "/applicants/#{@app_5.id}"

    fill_in :query, with: "Ze"

    click_on "Submit"

    expect(current_path).to eq("/applicants/#{@app_5.id}")

    expect(page).to have_content("Zeeb")
    expect(page).to have_content("Zeel")

    click_on "Adopt this Pet", id: @dog_4.id

    expect(page).to have_link "#{@dog_4.name}", href: "/pets/#{@dog_4.id}"


    visit "/applicants/#{@app_5.id}"

    fill_in :query, with: "Ze"

    click_on "Submit"

    expect(current_path).to eq("/applicants/#{@app_5.id}")

    expect(page).to have_content("Zeeb")
    expect(page).to have_content("Zeel")

    click_on "Adopt this Pet", id: @dog_5.id

    expect(page).to have_link "#{@dog_5.name}", href: "/pets/#{@dog_5.id}"
  end

  it "only shows submit and reason input field after pets have been added to the
      the application" do

    visit "/applicants/#{@app_6.id}"

    expect(page).to have_no_content("Why would you be a good home for these pet(s)?")

    fill_in :query, with: "Goofy"

    within("#pet") do
      click_on "Submit"
    end

    click_on "Adopt this Pet", id: @dog_3.id

    expect(page).to have_content("Why would you be a good home for these pet(s)?")

    fill_in :query, with: "Zeel"

    within("#pet") do
      click_on "Submit"
    end

    click_on "Adopt this Pet", id: @dog_5.id

    expect(page).to have_content("Why would you be a good home for these pet(s)?")
    expect(page).to have_content("Add a Pet to this Application")

    fill_in :reason, with: "I need a friend"

    within("#explanation") do
      click_on "Submit"
    end

    expect(page).to have_no_content("Add a Pet to this Application")
    expect(page).to have_content("Pending")
    expect(page).to have_link "#{@dog_3.name}", href: "/pets/#{@dog_3.id}"
    expect(page).to have_link "#{@dog_5.name}", href: "/pets/#{@dog_5.id}"
  end
end
