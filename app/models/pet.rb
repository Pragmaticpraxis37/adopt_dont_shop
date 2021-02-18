class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications
  validates_presence_of :name, :description, :approximate_age, :sex

  validates :approximate_age, numericality: {
              greater_than_or_equal_to: 0
            }

  enum sex: [:female, :male]

  def self.search_pet_name(name)
    Pet.where("lower(name) LIKE ?", "%#{name.downcase}%")
    # require "pry"; binding.pry

    # Pet.where("name LIKE ?", "%#{name}%")
  end

  def self.pets_non_adoptable(applicant)
    
  end
end
