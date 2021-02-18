class AdminController < ApplicationController

  def show
    if params[:applicant_id]
      @applicant = Application.find(params[:applicant_id])
    end

    if params[:shelter_id]
      @shelter = Shelter.name_and_address(params[:shelter_id])
    end
    require "pry"; binding.pry
  end

  def status_pet
    @applicant = Application.find(params[:applicant_id])
    @applicant.pet_applications.where("pet_id = ?", params[:pet_id]).update(status: params[:status])
    PetApplication.all_pets_statuses(@applicant)
    if @applicant.application_status == "Accepted"
      Pet.pets_non_adoptable(@applicant)
    end
    # @app_status = PetApplication.all_pets_statuses(@applicant)
    # Do you need to save this to a variable if it's changing the applicant?
    render :show
  end

  def index
    @shelters = Shelter.reverse_alphabetical
  end
end

# @pet = Pet.find(params[:pet_id]) unless params[:pet_id].nil?
# if !params[:pet_id].nil? && !params[:status].nil?
#   @status_pet = PetApplication.create!(application: @applicant, pet: @pet, status: params[:status])
# end
