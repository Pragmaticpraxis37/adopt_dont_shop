# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Pet.destroy_all
Shelter.destroy_all
Application.destroy_all
PetApplication.destroy_all

shelter_1 = Shelter.create!(name: "Shelter 1", address: "1111 1st Street",
                            city: "One City", state: "One State", zip: "11111")
shelter_2 = Shelter.create!(name: "Shelter 2", address: "2222 2nd Street",
                            city: "Two City", state: "Two State", zip: "22222")
shelter_3 = Shelter.create!(name: "Shelter 3", address: "3333 3rd Street",
                            city: "Three City", state: "Three State", zip: "33333")
shelter_4 = Shelter.create!(name: "Shelter 4", address: "4444 4th Street",
                            city: "Fourth City", state: "Fourth State", zip: "44444")


dog_1 = shelter_1.pets.create!(image: "", name: "Dog One", approximate_age: 1,
                      description: "doggo", sex: "male")
dog_2 = shelter_1.pets.create!(image: "", name: "Dog Two", approximate_age: 2,
                      description: "doggo", sex: "male")
dog_3 = shelter_1.pets.create!(image: "", name: "Dog Three", approximate_age: 3,
                      description: "doggo", sex: "male")
dog_4 = shelter_1.pets.create!(image: "", name: "Dog Four", approximate_age: 4,
                      description: "doggo", sex: "male")

dog_5 = shelter_2.pets.create!(image: "", name: "Dog Five", approximate_age: 5,
                      description: "doggo", sex: "male")
dog_6 = shelter_2.pets.create!(image: "", name: "Dog Six", approximate_age: 6,
                      description: "doggo", sex: "male")
dog_7 = shelter_2.pets.create!(image: "", name: "Dog Seven", approximate_age: 7,
                      description: "doggo", sex: "male")
dog_8 = shelter_2.pets.create!(image: "", name: "Dog Eight", approximate_age: 8,
                      description: "doggo", sex: "male")

dog_9 = shelter_3.pets.create!(image: "", name: "Dog Nine", approximate_age: 9,
                      description: "doggo", sex: "male")
dog_10 = shelter_3.pets.create!(image: "", name: "Dog Ten", approximate_age: 10,
                      description: "doggo", sex: "male")
dog_11 = shelter_3.pets.create!(image: "", name: "Dog Eleven", approximate_age: 11,
                      description: "doggo", sex: "male")
dog_12 = shelter_3.pets.create!(image: "", name: "Dog Twelve", approximate_age: 12,
                      description: "doggo", sex: "male")


dog_13 = shelter_4.pets.create!(image: "", name: "Dog Thirteen", approximate_age: 13,
                      description: "doggo", sex: "male")
dog_14 = shelter_4.pets.create!(image: "", name: "Dog Fourteen", approximate_age: 14,
                      description: "doggo", sex: "male")
dog_15 = shelter_4.pets.create!(image: "", name: "Dog Fifteen", approximate_age: 15,
                      description: "doggo", sex: "male")
dog_16 = shelter_4.pets.create!(image: "", name: "Dog Sixteen", approximate_age: 16,
                      description: "doggo", sex: "male")

applicant_1 = Application.create!(name: "Person One", address: "1111 1st Ave.",
                                  city: "One City", state: "One State", zip:
                                  11111, reason: "", names_of_pets: "",
                                  application_status: "In Progress")
applicant_2 = Application.create!(name: "Person Two", address: "2222 2nd Ave.",
                                  city: "Two City", state: "Two State", zip:
                                  22222, reason: "", names_of_pets: "",
                                  application_status: "In Progress")
applicant_3 = Application.create!(name: "Person Three", address: "3333 3rd Ave.",
                                  city: "Three City", state: "Three State", zip:
                                  33333, reason: "", names_of_pets: "",
                                  application_status: "In Progress")
applicant_4 = Application.create!(name: "Person Four", address: "4444 4th Ave.",
                                  city: "Four City", state: "Four State", zip:
                                  44444, reason: "", names_of_pets: "",
                                  application_status: "In Progress")
