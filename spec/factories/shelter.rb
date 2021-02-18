FactoryBot.define do
  factory :shelter do
    name {"Shelter"}
    address {"2222 Route Street"}
    city {"ThisCity"}
    state {"ThisState"}
    zip {"22222"}
  end
end


# create_table "shelters", force: :cascade do |t|
#   t.string "name"
#   t.string "address"
#   t.string "city"
#   t.string "state"
#   t.integer "zip"
# end
