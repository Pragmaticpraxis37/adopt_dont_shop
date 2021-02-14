require 'rails_helper'

RSpec.describe 'Applications index page' do
  before :each do
    @applicant_1 = create(:application)
    @applicant_2 = create(:application, name: "John Doe, Jr.", names_of_pets: "Zeus")
    @applicant_3 = create(:application, name: "Jane Doe", names_of_pets: "Goofy")
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
end


# before :each do
#   @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
#   @shelter2 = Shelter.create!(name: "Silly Shelter", address: "123 Silly Ave", city: "Longmont", state: "CO", zip: 80012)
#   @shelter3 = Shelter.create!(name: "Shell Shelter", address: "102 Shelter Dr.", city: "Commerce City", state: "CO", zip: 80022)
#   @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
#   @pet2 = @shelter2.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
#   @pet3 = @shelter1.pets.create!(image:"", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")
# end
#
# it "can create a new pet from Shelter Pet index page" do
#
#   visit "/shelters/#{@shelter1.id}/pets"
#
#   click_link "Add Pet"
#
#   expect(current_path).to eq("/shelters/#{@shelter1.id}/pets/new")
#
#   fill_in "image", with: ""
#   fill_in "name", with: 'Apollo'
#   fill_in "description", with: 'Dog'
#   fill_in "approximate_age", with: 3
#   fill_in "sex", with: "male"
#
#   click_on 'Create Pet'
#
#   expect(current_path).to eq("/shelters/#{@shelter1.id}/pets")
#
#   expect(page).to have_content("")
#   expect(page).to have_content("Apollo")
#   expect(page).to have_content(3)
#   expect(page).to have_content("male")
# end
