class AdminController < ApplicationController

  def show
    @applicant = Application.find(params[:applicant_id])
  end

  def status_pet
    @applicant = Application.find(params[:applicant_id])
    @applicant.pet_applications.where("pet_id = ?", params[:pet_id]).update(status: params[:status])
    render :show
  end
end

# @pet = Pet.find(params[:pet_id]) unless params[:pet_id].nil?
# if !params[:pet_id].nil? && !params[:status].nil?
#   @status_pet = PetApplication.create!(application: @applicant, pet: @pet, status: params[:status])
# end
