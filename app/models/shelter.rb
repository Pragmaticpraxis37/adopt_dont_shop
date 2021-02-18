class Shelter < ApplicationRecord
  has_many :pets

  def self.reverse_alphabetical
    Shelter.find_by_sql("SELECT name FROM shelters ORDER BY name desc")
  end

  def self.name_and_address(shelter_id)
    Shelter.find_by_sql("SELECT name, address, city, state FROM shelters WHERE id = #{shelter_id}")
  end
end
