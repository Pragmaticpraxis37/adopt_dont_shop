require 'rails_helper'

RSpec.describe 'Applications index page' do
  before :each do
    @applicant_1 = create(:application)
    @applicant_2 = create(:application, name: "John Doe, Jr.", names_of_pets: "Zeus")
    @applicant_3 = create(:application, name: "Jane Doe", names_of_pets: "Goofy")

    @dog_1 = create(:pet)
    @dog_2 = create(:pet, name: "Zeus")
    @dog_3 = create(:pet, name: "Goofy")
  end

  it "displays a link to 'Start an Application' on the pet index page that goes
      to a new applicant form that can create a new application" do

    visit "/pets"

    expect(page).to have_link 'Start an Application', href: "/applicants/new"

    click_link "Start an Application", href: "/applicants/new"

    expect(current_path).to eq("/applicants/new")

    fill_in "name", with: "John Doe"
    fill_in "address", with: "1111 Main Street"
    fill_in "city", with: "Anycity"
    fill_in "state", with: "Anystate"
    fill_in "zip", with: "11111"

    click_on 'Create Application'

    expect(current_path).to eq("/applicants/#{Application.all.last.id}")

    expect(page).to have_content("John Doe")
    expect(page).to have_content("1111 Main Street")
    expect(page).to have_content("Anycity")
    expect(page).to have_content("Anystate")
    expect(page).to have_content("11111")
    expect(page).to have_content("In Progress")
  end

  it "redirects back to the new application page when all fields aren't filled in" do

    visit "/pets"

    click_link "Start an Application", href: "/applicants/new"

    fill_in "name", with: "John Doe"
    fill_in "address", with: "1111 Main Street"
    fill_in "city", with: ""
    fill_in "state", with: "Anystate"
    fill_in "zip", with: "11111"

    click_on 'Create Application'

    expect(page).to have_content("Application not created, please fill out all fields")
    expect(page).to have_button('Create Application')

    fill_in "name", with: "John Doe"
    fill_in "address", with: "1111 Main Street"
    fill_in "city", with: "Anycity"
    fill_in "state", with: ""
    fill_in "zip", with: "11111"

    click_on 'Create Application'

    expect(page).to have_content("Application not created, please fill out all fields")
    expect(page).to have_button('Create Application')
  end
end
