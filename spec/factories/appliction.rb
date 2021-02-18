FactoryBot.define do
  factory :application do
    name {"John Doe"}
    address {"1111 Main Street"}
    city {"Anycity"}
    state {"Anystate"}
    zip {"11111"}
    reason {""}
    names_of_pets {""}
    application_status {"In Progress"}
  end
end


  # create_table "applications", force: :cascade do |t|
  #   t.string "name"
  #   t.string "address"
  #   t.string "city"
  #   t.string "state"
  #   t.string "zip"
  #   t.string "reason"
  #   t.string "names_of_pets"
  #   t.string "application_status"
  # end
  #
  #
  # factory :admin, class: Pet do
  #   sequence(:image) {|n| ""}
  #   sequence(:name) {|n| "Zeus #{n}"}
  #   sequence(:description) {|n| "dog #{n}"}
  #   sequence(:approximate_age) {|n| n+4}
  #   sequence(:sex) {|n| "male"}
  #   shelter
  # end
  #
  # factory :pet do
  #   image {""}
  #   name {"Zeus"}
  #   description {"dog"}
  #   approximate_age {4}
  #   sex {"male"}
  #   shelter
  # end
# end
